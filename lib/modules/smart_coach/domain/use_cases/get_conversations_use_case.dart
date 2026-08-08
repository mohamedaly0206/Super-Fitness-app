import 'package:injectable/injectable.dart';

import '../entities/conversation.dart';
import '../repositories/conversation_repository.dart';

@injectable
class GetConversationsUseCase {
  final ConversationRepository _repository;

  GetConversationsUseCase(this._repository);

  Future<List<Conversation>> call() {
    return _repository.getConversations();
  }
}
