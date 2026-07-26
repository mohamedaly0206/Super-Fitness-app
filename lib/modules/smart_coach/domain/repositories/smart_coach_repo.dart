import '../entities/chat_message.dart';

abstract class SmartCoachRepo {
  Stream<String> streamChat({
    required List<ChatMessage> messages,
    String model,
  });

  Future<String> sendChat({
    required List<ChatMessage> messages,
    String model,
  });

  Future<bool> isOllamaRunning();

  void close();
}
