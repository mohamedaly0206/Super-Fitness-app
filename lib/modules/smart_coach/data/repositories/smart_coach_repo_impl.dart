import 'package:injectable/injectable.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/smart_coach_repo.dart';
import '../datasources/smart_coach_remote_data_source.dart';

@Injectable(as: SmartCoachRepo)
class SmartCoachRepoImpl implements SmartCoachRepo {
  final SmartCoachRemoteDataSource _remoteDataSource;

  SmartCoachRepoImpl(this._remoteDataSource);

  @override
  Stream<String> streamChat({
    required List<ChatMessage> messages,
    String model = 'gemma3:1b',
    String languageCode = 'en',
  }) {
    return _remoteDataSource.streamChat(
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
    return _remoteDataSource.sendChat(
      messages: messages,
      model: model,
      languageCode: languageCode,
    );
  }

  @override
  Future<bool> isOllamaRunning() {
    return _remoteDataSource.isOllamaRunning();
  }

  @override
  Future<String> generateChatTitle({required String firstMessage}) {
    return _remoteDataSource.generateChatTitle(firstMessage: firstMessage);
  }

  @override
  void close() {
    _remoteDataSource.close();
  }
}
