import 'package:injectable/injectable.dart';

import '../entities/conversation.dart';
import '../repositories/conversation_repository.dart';

@injectable
class CreateConversationUseCase {
  final ConversationRepository _repository;

  CreateConversationUseCase(this._repository);

  Future<void> call(Conversation conversation) {
    return _repository.createConversation(conversation);
  }
}
