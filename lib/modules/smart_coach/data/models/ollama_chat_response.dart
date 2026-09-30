import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/chat_message.dart';

part 'ollama_chat_response.g.dart';

@JsonSerializable()
class OllamaChatResponse {
  final String model;
  final ChatMessageDto? message;
  @JsonKey(name: 'done')
  final bool done;
  @JsonKey(name: 'total_duration')
  final int? totalDuration;
  @JsonKey(name: 'eval_count')
  final int? evalCount;

  const OllamaChatResponse({
    required this.model,
    this.message,
    required this.done,
    this.totalDuration,
    this.evalCount,
  });

  factory OllamaChatResponse.fromJson(Map<String, dynamic> json) =>
      _$OllamaChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OllamaChatResponseToJson(this);

  ChatMessage? toChatMessage() {
    if (message == null) return null;
    return ChatMessage(role: message!.role, content: message!.content);
  }
}

@JsonSerializable()
class ChatMessageDto {
  final String role;
  final String content;

  const ChatMessageDto({required this.role, required this.content});

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageDtoToJson(this);
}
