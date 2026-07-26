import '../entities/chat_message.dart';

abstract class SmartCoachRepo {
  Stream<String> streamChat({
    required List<ChatMessage> messages,
    String model,
    String languageCode,
  });

  Future<String> sendChat({
    required List<ChatMessage> messages,
    String model,
    String languageCode,
  });

  Future<bool> isOllamaRunning();

  Future<String> generateChatTitle({required String firstMessage});

  void close();
}
