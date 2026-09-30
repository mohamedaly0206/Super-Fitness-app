import 'package:injectable/injectable.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../datasources/conversation_remote_data_source.dart';
import '../models/conversation_dto.dart';

@Injectable(as: ConversationRepository)
class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource _remoteDataSource;

  ConversationRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> createConversation(Conversation conversation) {
    return _remoteDataSource.createConversation(
      ConversationDto.fromEntity(conversation),
    );
  }

  @override
  Future<void> updateConversation(Conversation conversation) {
    return _remoteDataSource.updateConversation(
      ConversationDto.fromEntity(conversation),
    );
  }

  @override
  Future<void> deleteConversation(String conversationId) {
    return _remoteDataSource.deleteConversation(conversationId);
  }

  @override
  Future<Conversation?> getConversation(String conversationId) async {
    final dto = await _remoteDataSource.getConversation(conversationId);
    return dto?.toEntity();
  }

  @override
  Future<List<Conversation>> getConversations() async {
    final result = await _remoteDataSource.getConversations();

    return result.map((e) => e.toEntity()).toList();
  }
}
