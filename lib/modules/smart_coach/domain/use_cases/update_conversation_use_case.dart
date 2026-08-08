import 'package:injectable/injectable.dart';

import '../entities/conversation.dart';
import '../repositories/conversation_repository.dart';

@injectable
class UpdateConversationUseCase {
  final ConversationRepository _repository;

  UpdateConversationUseCase(this._repository);

  Future<void> call(Conversation conversation) {
    return _repository.updateConversation(conversation);
  }
}
