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
  }) {
    return _ollamaClient.sendChatMessageStream(
      messages: messages,
      model: model,
    );
  }

  @override
  Future<String> sendChat({
    required List<ChatMessage> messages,
    String model = 'gemma3:1b',
  }) {
    return _ollamaClient.sendChatMessage(
      messages: messages,
      model: model,
    );
  }

  @override
  Future<bool> isOllamaRunning() {
    return _ollamaClient.isServerRunning();
  }

  @override
  void close() {
    _ollamaClient.close();
  }
}
