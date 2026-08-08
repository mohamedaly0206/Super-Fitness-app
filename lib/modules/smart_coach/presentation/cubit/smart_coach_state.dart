import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/chat_session.dart';

import '../../domain/entities/conversation.dart';

class SmartCoachState extends Equatable {
  final List<Conversation> conversations;

  final ChatSession? currentSession;

  final bool isTyping;

  final bool isLoading;

  final bool limitReached;

  final String? errorMessage;

  const SmartCoachState({
    this.conversations = const [],
    this.currentSession,
    this.isTyping = false,
    this.isLoading = false,
    this.limitReached = false,
    this.errorMessage,
  });

  SmartCoachState copyWith({
    List<Conversation>? conversations,
    ChatSession? currentSession,
    bool? isTyping,
    bool? isLoading,
    bool? limitReached,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SmartCoachState(
      conversations: conversations ?? this.conversations,
      currentSession: currentSession ?? this.currentSession,
      isTyping: isTyping ?? this.isTyping,
      isLoading: isLoading ?? this.isLoading,
      limitReached: limitReached ?? this.limitReached,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    conversations,
    currentSession,
    isTyping,
    isLoading,
    limitReached,
    errorMessage,
  ];
}
