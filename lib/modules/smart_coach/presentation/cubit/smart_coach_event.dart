sealed class SmartCoachEvent {
  const SmartCoachEvent();
}

class LoadConversationsEvent extends SmartCoachEvent {
  const LoadConversationsEvent();
}

class OpenConversationEvent extends SmartCoachEvent {
  final String conversationId;

  const OpenConversationEvent(this.conversationId);
}

class SendMessageEvent extends SmartCoachEvent {
  final String message;

  const SendMessageEvent(this.message);
}

class DeleteConversationEvent extends SmartCoachEvent {
  final String conversationId;

  const DeleteConversationEvent(this.conversationId);
}

class CreateNewConversationEvent extends SmartCoachEvent {
  const CreateNewConversationEvent();
}

class RetryLastMessageEvent extends SmartCoachEvent {
  const RetryLastMessageEvent();
}
