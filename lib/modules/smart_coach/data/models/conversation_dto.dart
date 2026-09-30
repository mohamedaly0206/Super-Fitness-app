import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/entities/conversation_status.dart';

part 'conversation_dto.g.dart';

@JsonSerializable()
class ConversationDto {
  final String id;
  final String title;
  final int totalTokens;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String status;

  const ConversationDto({
    required this.id,
    required this.title,
    required this.totalTokens,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory ConversationDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDtoToJson(this);

  factory ConversationDto.fromEntity(Conversation entity) {
    return ConversationDto(
      id: entity.id,
      title: entity.title,
      totalTokens: entity.totalTokens,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status.name,
    );
  }

  Conversation toEntity() {
    return Conversation(
      id: id,
      title: title,
      totalTokens: totalTokens,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: ConversationStatus.values.firstWhere((e) => e.name == status),
    );
  }
}
