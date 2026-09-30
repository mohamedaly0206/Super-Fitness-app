import 'package:super_fitness_app/modules/smart_coach/data/models/message_dto.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/chat_message.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message_role.dart';

extension MessageToChatMapper on Message {
  ChatMessage toChatMessage() {
    return ChatMessage(role: role.name, content: content);
  }
}

extension ChatMessageToMessageMapper on ChatMessage {
  Message toMessage({
    required String id,
    required String conversationId,
    required DateTime createdAt,
  }) {
    return Message(
      id: id,
      conversationId: conversationId,
      role: MessageRole.values.firstWhere(
        (e) => e.name == role,
        orElse: () => MessageRole.user,
      ),
      content: content,
      createdAt: createdAt,
    );
  }
}

extension MessageToDtoMapper on Message {
  MessageDto toDto() {
    return MessageDto.fromEntity(this);
  }
}

extension MessageDtoToEntityMapper on MessageDto {
  Message toEntityModel() {
    return toEntity();
  }
}
