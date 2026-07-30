sealed class SmartCoachIntent {
  const SmartCoachIntent();
}

class LoadConversationsIntent extends SmartCoachIntent {
  const LoadConversationsIntent();
}

class OpenConversationIntent extends SmartCoachIntent {
  final String conversationId;

  const OpenConversationIntent(this.conversationId);
}

class SendMessageIntent extends SmartCoachIntent {
  final String message;

  const SendMessageIntent(this.message);
}

class DeleteConversationIntent extends SmartCoachIntent {
  final String conversationId;

  const DeleteConversationIntent(this.conversationId);
}

class CreateNewConversationIntent extends SmartCoachIntent {
  const CreateNewConversationIntent();
}

class RetryLastMessageIntent extends SmartCoachIntent {
  const RetryLastMessageIntent();
}
