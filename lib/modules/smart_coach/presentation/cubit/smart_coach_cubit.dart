import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/chat_session.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/conversation.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/conversation_status.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/mart_coach_stream_event.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message_role.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/add_message_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/create_conversation_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/delete_conversation_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/get_conversation_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/get_conversations_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/get_messages_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/use_cases/send_smart_coach_message_use_case.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/smart_coach_constants.dart';
import 'package:uuid/uuid.dart';
import 'smart_coach_intent.dart';
import 'smart_coach_state.dart';

@injectable
class SmartCoachCubit extends Cubit<SmartCoachState> {
  final CreateConversationUseCase _createConversationUseCase;
  final DeleteConversationUseCase _deleteConversationUseCase;
  final GetConversationUseCase _getConversationUseCase;
  final GetConversationsUseCase _getConversationsUseCase;
  final GetMessagesUseCase _getMessagesUseCase;
  final SendSmartCoachMessageUseCase _sendSmartCoachMessageUseCase;
  final AddMessageUseCase _addMessageUseCase;
  final _uuid = const Uuid();
  bool _conversationPersisted = false;

  StreamSubscription? _streamSubscription;

  SmartCoachCubit(
    this._createConversationUseCase,
    this._deleteConversationUseCase,
    this._getConversationUseCase,
    this._getConversationsUseCase,
    this._getMessagesUseCase,
    this._sendSmartCoachMessageUseCase,
    this._addMessageUseCase,
  ) : super(const SmartCoachState());

  Future<void> doIntent(SmartCoachIntent intent) async {
    switch (intent) {
      case LoadConversationsIntent():
        await _loadConversations();

      case CreateNewConversationIntent():
        await _createConversation();

      case OpenConversationIntent():
        await _openConversation(intent.conversationId);

      case SendMessageIntent():
        await _sendMessage(intent.message);

      case DeleteConversationIntent():
        await _deleteConversation(intent.conversationId);

      case RetryLastMessageIntent():
        // هننفذها بعدين
        break;
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }

  // ---------------- Private Methods ----------------

  Future<void> _loadConversations() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final conversations = await _getConversationsUseCase();

      emit(state.copyWith(conversations: conversations, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _createConversation() async {
    final now = DateTime.now();

    final conversation = Conversation(
      id: _uuid.v4(),
      title: 'No Title',
      totalTokens: 0,
      createdAt: now,
      updatedAt: now,
      status: ConversationStatus.active,
    );

    final session = ChatSession(
      conversation: conversation,
      messages: const [],
    );

    _conversationPersisted = false;

    emit(
      state.copyWith(
        currentSession: session,
        conversations: [conversation, ...state.conversations],
        clearError: true,
      ),
    );
    await _createGreeting();
  }

  Future<void> _openConversation(String conversationId) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final conversation = await _getConversationUseCase(conversationId);

      if (conversation == null) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Conversation not found.',
          ),
        );
        return;
      }

      final messages = await _getMessagesUseCase(conversationId);

      final session = ChatSession(
        conversation: conversation,
        messages: messages,
      );

      emit(state.copyWith(currentSession: session, isLoading: false));
      _conversationPersisted = true;
      await _createGreeting();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _persistCurrentSession() async {
    final session = state.currentSession;
    if (session == null) return;

    await _createConversationUseCase(session.conversation);
    for (final message in session.messages) {
      await _addMessageUseCase(message);
    }
    _conversationPersisted = true;
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return;
    }

    if (state.currentSession == null) {
      await _createConversation();
    }

    if (!_conversationPersisted) {
      try {
        await _persistCurrentSession();
      } catch (e) {
        emit(state.copyWith(errorMessage: e.toString()));
        return;
      }
    }

    ChatSession session = state.currentSession!;

    emit(state.copyWith(isTyping: true, clearError: true));

    _streamSubscription?.cancel();

    String streamedText = '';

    _streamSubscription =
        _sendSmartCoachMessageUseCase(
          conversation: session.conversation,
          previousMessages: session.messages,
          userMessage: text,
        ).listen(
          (event) {
            switch (event) {
              case UserMessageSaved():
                session = session.copyWith(
                  messages: [...session.messages, event.message],
                );

                emit(state.copyWith(currentSession: session));

              case AssistantChunkReceived():
                streamedText += event.chunk;

                final messages = [...session.messages];

                if (messages.isNotEmpty &&
                    messages.last.role == MessageRole.assistant &&
                    messages.last.id == 'streaming') {
                  messages[messages.length - 1] = messages.last.copyWith(
                    content: streamedText,
                  );
                } else {
                  messages.add(
                    Message(
                      id: 'streaming',
                      conversationId: session.conversation.id,
                      role: MessageRole.assistant,
                      content: streamedText,
                      createdAt: DateTime.now(),
                    ),
                  );
                }

                session = session.copyWith(messages: messages);

                emit(state.copyWith(currentSession: session));

              case AssistantMessageSaved():
                final messages = [...session.messages];

                if (messages.isNotEmpty && messages.last.id == 'streaming') {
                  messages[messages.length - 1] = event.message;
                } else {
                  messages.add(event.message);
                }

                session = session.copyWith(messages: messages);

                emit(state.copyWith(currentSession: session));

              case ConversationUpdated():
                session = session.copyWith(conversation: event.conversation);

                final conversations = [...state.conversations];

                final index = conversations.indexWhere(
                  (e) => e.id == event.conversation.id,
                );

                if (index != -1) {
                  conversations[index] = event.conversation;
                } else {
                  conversations.insert(0, event.conversation);
                }

                conversations.sort(
                  (a, b) => b.updatedAt.compareTo(a.updatedAt),
                );

                emit(
                  state.copyWith(
                    currentSession: session,
                    conversations: conversations,
                  ),
                );
            }
          },
          onError: (e) {
            emit(state.copyWith(isTyping: false, errorMessage: e.toString()));
          },
          onDone: () {
            emit(state.copyWith(isTyping: false));
          },
          cancelOnError: true,
        );
  }

  Future<void> _deleteConversation(String conversationId) async {
    try {
      if (_conversationPersisted) {
        await _deleteConversationUseCase(conversationId);
      }

      final conversations = state.conversations
          .where((e) => e.id != conversationId)
          .toList();

      ChatSession? currentSession = state.currentSession;

      if (currentSession?.conversation.id == conversationId) {
        currentSession = null;
      }

      emit(
        state.copyWith(
          conversations: conversations,
          currentSession: currentSession,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _createGreeting() async {
    if (state.currentSession == null) return;

    final session = state.currentSession!;

    if (session.messages.isNotEmpty) return;

    final message = Message(
      id: _uuid.v4(),
      conversationId: session.conversation.id,
      role: MessageRole.assistant,
      content: SmartCoachConstants.greeting,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(currentSession: session.copyWith(messages: [message])));
  }
}
