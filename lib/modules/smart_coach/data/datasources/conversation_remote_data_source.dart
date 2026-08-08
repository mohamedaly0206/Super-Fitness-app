import 'package:super_fitness_app/modules/smart_coach/data/models/conversation_dto.dart';

abstract class ConversationRemoteDataSource {
  Future<void> createConversation(ConversationDto conversation);

  Future<void> updateConversation(ConversationDto conversation);

  Future<void> deleteConversation(String conversationId);

  Future<List<ConversationDto>> getConversations();

  Future<ConversationDto?> getConversation(String conversationId);
}
