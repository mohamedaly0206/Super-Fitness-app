import '../entities/message.dart';

abstract class SmartCoachRepo {
  Stream<String> streamChat({required List<Message> messages, String model});

  Future<String> sendChat({required List<Message> messages, String model});

  Future<bool> isOllamaRunning();

  Future<String> generateChatTitle({required String firstMessage});

  void close();
}
