import '../entities/message.dart';

abstract class MessageRepository {
  Future<void> addMessage(Message message);

  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
  });

  Future<List<Message>> getMessages(String conversationId);
}
