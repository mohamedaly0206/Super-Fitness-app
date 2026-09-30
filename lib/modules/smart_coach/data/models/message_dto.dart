import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message_role.dart';

import '../../domain/entities/message.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  final String id;
  final String conversationId;
  final String role;
  final String content;
  final DateTime createdAt;

  const MessageDto({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  factory MessageDto.fromEntity(Message entity) {
    return MessageDto(
      id: entity.id,
      conversationId: entity.conversationId,
      role: entity.role.name,
      content: entity.content,
      createdAt: entity.createdAt,
    );
  }

  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      role: MessageRole.values.firstWhere((e) => e.name == role),
      content: content,
      createdAt: createdAt,
    );
  }
}
