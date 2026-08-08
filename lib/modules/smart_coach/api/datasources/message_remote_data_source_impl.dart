import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/smart_coach/data/datasources/message_remote_data_source.dart';
import 'package:super_fitness_app/modules/smart_coach/data/models/message_dto.dart';

@LazySingleton(as: MessageRemoteDataSource)
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore _firestore;

  MessageRemoteDataSourceImpl(this._firestore);

  Future<CollectionReference<Map<String, dynamic>>> _messages(
      String conversationId) async {
    final userId = await SecureStorageService.getUserId();
    if (userId == null || userId.isEmpty) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('conversations')
        .doc(conversationId)
        .collection('messages');
  }

  @override
  Future<void> addMessage(MessageDto message) async {
    final col = await _messages(message.conversationId);
    await col.doc(message.id).set(message.toJson());
  }

  @override
  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
  }) async {
    final col = await _messages(conversationId);
    await col.doc(messageId).delete();
  }

  @override
  Future<List<MessageDto>> getMessages(String conversationId) async {
    final col = await _messages(conversationId);
    final snapshot = await col
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs.map((e) => MessageDto.fromJson(e.data())).toList();
  }
}
