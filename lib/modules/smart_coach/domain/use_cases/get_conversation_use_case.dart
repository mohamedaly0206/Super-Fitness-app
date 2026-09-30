import 'package:injectable/injectable.dart';

import '../entities/conversation.dart';
import '../repositories/conversation_repository.dart';

@injectable
class GetConversationUseCase {
  final ConversationRepository _repository;

  GetConversationUseCase(this._repository);

  Future<Conversation?> call(String conversationId) {
    return _repository.getConversation(conversationId);
  }
}
