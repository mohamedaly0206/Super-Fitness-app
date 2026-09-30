import '../models/message_dto.dart';

abstract class MessageRemoteDataSource {
  Future<void> addMessage(MessageDto message);

  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
  });

  Future<List<MessageDto>> getMessages(String conversationId);
}
