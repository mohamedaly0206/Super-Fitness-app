import 'package:injectable/injectable.dart';

import '../repositories/message_repository.dart';

@injectable
class DeleteMessageUseCase {
  final MessageRepository _repository;

  DeleteMessageUseCase(this._repository);

  Future<void> call({
    required String conversationId,
    required String messageId,
  }) {
    return _repository.deleteMessage(
      conversationId: conversationId,
      messageId: messageId,
    );
  }
}
