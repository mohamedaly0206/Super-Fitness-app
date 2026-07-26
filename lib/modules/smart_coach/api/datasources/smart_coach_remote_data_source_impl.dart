import 'package:injectable/injectable.dart';

import '../../data/datasources/smart_coach_remote_data_source.dart';
import '../../domain/entities/chat_message.dart';
import '../api_client/ollama_api_client.dart';

@LazySingleton(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {
  final OllamaApiClient _ollamaClient;

  SmartCoachRemoteDataSourceImpl(this._ollamaClient);

  @override
  Stream<String> streamChat({
    required List<ChatMessage> messages,
    String model = 'gemma3:1b',
    String languageCode = 'en',
  }) {
    return _ollamaClient.sendChatMessageStream(
      messages: messages,
      model: model,
      languageCode: languageCode,
    );
  }

  @override
  Future<String> sendChat({
    required List<ChatMessage> messages,
    String model = 'gemma3:1b',
    String languageCode = 'en',
  }) {
    return _ollamaClient.sendChatMessage(
      messages: messages,
      model: model,
      languageCode: languageCode,
    );
  }

  @override
  Future<bool> isOllamaRunning() {
    return _ollamaClient.isServerRunning();
  }

  @override
  Future<String> generateChatTitle({required String firstMessage}) {
    return _ollamaClient.generateChatTitle(firstMessage: firstMessage);
  }

  @override
  void close() {
    _ollamaClient.close();
  }
}
