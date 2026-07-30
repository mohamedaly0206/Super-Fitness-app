import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/mapper/message_mapper.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/smart_coach_repo.dart';
import '../datasources/smart_coach_remote_data_source.dart';

@Injectable(as: SmartCoachRepo)
class SmartCoachRepoImpl implements SmartCoachRepo {
  final SmartCoachRemoteDataSource _remoteDataSource;

  SmartCoachRepoImpl(this._remoteDataSource);

  @override
  Stream<String> streamChat({
    required List<Message> messages,
    String model = 'gemma3:1b',
  }) {
    final chatMessages = messages
        .map((message) => message.toChatMessage())
        .toList();

    return _remoteDataSource.streamChat(messages: chatMessages, model: model);
  }

  @override
  Future<String> sendChat({
    required List<Message> messages,
    String model = 'gemma3:1b',
  }) {
    final chatMessages = messages
        .map((message) => message.toChatMessage())
        .toList();

    return _remoteDataSource.sendChat(messages: chatMessages, model: model);
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
