import 'package:super_fitness_app/modules/smart_coach/domain/entities/conversation.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message.dart';

sealed class SmartCoachStreamEvent {
  const SmartCoachStreamEvent();
}

class UserMessageSaved extends SmartCoachStreamEvent {
  final Message message;

  const UserMessageSaved(this.message);
}

class AssistantChunkReceived extends SmartCoachStreamEvent {
  final String chunk;

  const AssistantChunkReceived(this.chunk);
}

class AssistantMessageSaved extends SmartCoachStreamEvent {
  final Message message;

  const AssistantMessageSaved(this.message);
}

class ConversationUpdated extends SmartCoachStreamEvent {
  final Conversation conversation;

  const ConversationUpdated(this.conversation);
}
