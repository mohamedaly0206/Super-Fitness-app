import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/smart_coach/data/datasources/conversation_remote_data_source.dart';
import 'package:super_fitness_app/modules/smart_coach/data/models/conversation_dto.dart';

@LazySingleton(as: ConversationRemoteDataSource)
class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final FirebaseFirestore _firestore;

  ConversationRemoteDataSourceImpl(this._firestore);

  Future<CollectionReference<Map<String, dynamic>>> _getCollection() async {
    final userId = await SecureStorageService.getUserId();
    if (userId == null || userId.isEmpty) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('conversations');
  }

  @override
  Future<void> createConversation(ConversationDto conversation) async {
    final col = await _getCollection();
    await col.doc(conversation.id).set(conversation.toJson());
  }

  @override
  Future<void> updateConversation(ConversationDto conversation) async {
    final col = await _getCollection();
    await col
        .doc(conversation.id)
        .set(conversation.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    final col = await _getCollection();
    await col.doc(conversationId).delete();
  }

  @override
  Future<ConversationDto?> getConversation(String conversationId) async {
    final col = await _getCollection();
    final doc = await col.doc(conversationId).get();

    if (!doc.exists) {
      return null;
    }

    return ConversationDto.fromJson(doc.data()!);
  }

  @override
  Future<List<ConversationDto>> getConversations() async {
    final col = await _getCollection();
    final snapshot = await col
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs
        .map((e) => ConversationDto.fromJson(e.data()))
        .toList();
  }
}
