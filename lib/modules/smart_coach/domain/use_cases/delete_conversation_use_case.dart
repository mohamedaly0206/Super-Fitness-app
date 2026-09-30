import 'package:injectable/injectable.dart';

import '../repositories/conversation_repository.dart';

@injectable
class DeleteConversationUseCase {
  final ConversationRepository _repository;

  DeleteConversationUseCase(this._repository);

  Future<void> call(String conversationId) {
    return _repository.deleteConversation(conversationId);
  }
}
