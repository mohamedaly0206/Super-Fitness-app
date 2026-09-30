import 'package:injectable/injectable.dart';

import '../entities/message.dart';
import '../repositories/message_repository.dart';

@injectable
class GetMessagesUseCase {
  final MessageRepository _repository;

  GetMessagesUseCase(this._repository);

  Future<List<Message>> call(String conversationId) {
    return _repository.getMessages(conversationId);
  }
}
