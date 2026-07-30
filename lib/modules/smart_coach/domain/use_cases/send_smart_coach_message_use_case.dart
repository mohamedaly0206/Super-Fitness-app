import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/ai_config.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/mart_coach_stream_event.dart';
import 'package:uuid/uuid.dart';

import '../entities/conversation.dart';
import '../entities/conversation_status.dart';
import '../entities/message.dart';
import '../entities/message_role.dart';
import '../repositories/conversation_repository.dart';
import '../repositories/message_repository.dart';
import '../repositories/smart_coach_repo.dart';

@injectable
class SendSmartCoachMessageUseCase {
  final SmartCoachRepo _smartCoachRepo;
  final ConversationRepository _conversationRepository;
  final MessageRepository _messageRepository;

  final _uuid = const Uuid();

  SendSmartCoachMessageUseCase(
    this._smartCoachRepo,
    this._conversationRepository,
    this._messageRepository,
  );

  Stream<SmartCoachStreamEvent> call({
    required Conversation conversation,
    required List<Message> previousMessages,
    required String userMessage,
  }) async* {
    /// لو الليميت وصل
    if (conversation.status == ConversationStatus.limitReached) {
      throw Exception('This conversation has reached the maximum token limit.');
    }

    /// Save user message
    final user = Message(
      id: _uuid.v4(),
      conversationId: conversation.id,
      role: MessageRole.user,
      content: userMessage,
      createdAt: DateTime.now(),
    );

    await _messageRepository.addMessage(user);

    yield UserMessageSaved(user);

    final messages = [...previousMessages, user];

    String assistantResponse = '';

    /// Stream AI response
    await for (final chunk in _smartCoachRepo.streamChat(messages: messages)) {
      assistantResponse += chunk;

      yield AssistantChunkReceived(chunk);
    }

    /// Save assistant message
    final assistant = Message(
      id: _uuid.v4(),
      conversationId: conversation.id,
      role: MessageRole.assistant,
      content: assistantResponse,
      createdAt: DateTime.now(),
    );

    await _messageRepository.addMessage(assistant);

    yield AssistantMessageSaved(assistant);

    /// -------- Token Count --------

    final estimatedTokens =
        _estimateTokens(userMessage) + _estimateTokens(assistantResponse);

    final totalTokens = conversation.totalTokens + estimatedTokens;

    /// -------- Update Conversation --------

    Conversation updatedConversation = conversation.copyWith(
      updatedAt: DateTime.now(),
      totalTokens: totalTokens,
      status: totalTokens >= AiConfig.maxConversationTokens
          ? ConversationStatus.limitReached
          : ConversationStatus.active,
    );

    /// First Message => Generate Title
    print("previousMessages = ${previousMessages.length}");

    final title = await _smartCoachRepo.generateChatTitle(
      firstMessage: userMessage,
    );

    print("Generated Title = $title");

    updatedConversation = updatedConversation.copyWith(title: title);

    await _conversationRepository.updateConversation(updatedConversation);

    yield ConversationUpdated(updatedConversation);
  }

  /// Temporary estimation
  /// تقريباً كل 4 حروف = Token
  int _estimateTokens(String text) {
    return (text.length / 4).ceil();
  }
}
