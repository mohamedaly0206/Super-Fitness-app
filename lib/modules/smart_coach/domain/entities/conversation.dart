import 'package:equatable/equatable.dart';

import 'conversation_status.dart';

class Conversation extends Equatable {
  final String id;
  final String title;
  final int totalTokens;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ConversationStatus status;

  const Conversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.totalTokens = 0,
    this.status = ConversationStatus.active,
  });

  Conversation copyWith({
    String? id,
    String? title,
    int? totalTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    ConversationStatus? status,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      totalTokens: totalTokens ?? this.totalTokens,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    totalTokens,
    createdAt,
    updatedAt,
    status,
  ];
}
