import 'package:injectable/injectable.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';
import '../models/message_dto.dart';

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource _remoteDataSource;

  MessageRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addMessage(Message message) {
    return _remoteDataSource.addMessage(MessageDto.fromEntity(message));
  }

  @override
  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
  }) {
    return _remoteDataSource.deleteMessage(
      conversationId: conversationId,
      messageId: messageId,
    );
  }

  @override
  Future<List<Message>> getMessages(String conversationId) async {
    final result = await _remoteDataSource.getMessages(conversationId);

    return result.map((e) => e.toEntity()).toList();
  }
}
