import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/modules/smart_coach/data/datasources/message_remote_data_source.dart';
import 'package:super_fitness_app/modules/smart_coach/data/models/message_dto.dart';

@LazySingleton(as: MessageRemoteDataSource)
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore _firestore;

  MessageRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> _messages(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages');
  }

  @override
  Future<void> addMessage(MessageDto message) async {
    await _messages(
      message.conversationId,
    ).doc(message.id).set(message.toJson());
  }

  @override
  Future<void> deleteMessage({
    required String conversationId,
    required String messageId,
  }) async {
    await _messages(conversationId).doc(messageId).delete();
  }

  @override
  Future<List<MessageDto>> getMessages(String conversationId) async {
    final snapshot = await _messages(
      conversationId,
    ).orderBy('createdAt', descending: false).get();

    return snapshot.docs.map((e) => MessageDto.fromJson(e.data())).toList();
  }
}
