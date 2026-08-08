import 'package:injectable/injectable.dart';

import '../entities/message.dart';
import '../repositories/message_repository.dart';

@injectable
class AddMessageUseCase {
  final MessageRepository _repository;

  AddMessageUseCase(this._repository);

  Future<void> call(Message message) {
    return _repository.addMessage(message);
  }
}
