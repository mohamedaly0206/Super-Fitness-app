import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/modules/smart_coach/data/datasources/conversation_remote_data_source.dart';
import 'package:super_fitness_app/modules/smart_coach/data/models/conversation_dto.dart';

@LazySingleton(as: ConversationRemoteDataSource)
class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final FirebaseFirestore _firestore;

  ConversationRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('conversations');

  @override
  Future<void> createConversation(ConversationDto conversation) async {
    await _collection.doc(conversation.id).set(conversation.toJson());
  }

  @override
  Future<void> updateConversation(ConversationDto conversation) async {
    await _collection
        .doc(conversation.id)
        .set(conversation.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    await _collection.doc(conversationId).delete();
  }

  @override
  Future<ConversationDto?> getConversation(String conversationId) async {
    final doc = await _collection.doc(conversationId).get();

    if (!doc.exists) {
      return null;
    }

    return ConversationDto.fromJson(doc.data()!);
  }

  @override
  Future<List<ConversationDto>> getConversations() async {
    final snapshot = await _collection
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs
        .map((e) => ConversationDto.fromJson(e.data()))
        .toList();
  }
}
