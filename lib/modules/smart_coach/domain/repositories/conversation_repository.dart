import '../entities/conversation.dart';

abstract class ConversationRepository {
  Future<void> createConversation(Conversation conversation);

  Future<void> updateConversation(Conversation conversation);

  Future<void> deleteConversation(String conversationId);

  Future<List<Conversation>> getConversations();

  Future<Conversation?> getConversation(String conversationId);
}
