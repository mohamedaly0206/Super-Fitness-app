import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String role;
  final String content;

  const ChatMessage({
    required this.role,
    required this.content,
  });

  const ChatMessage.user(String content)
      : role = 'user',
        content = content;

  const ChatMessage.assistant(String content)
      : role = 'assistant',
        content = content;

  const ChatMessage.system(String content)
      : role = 'system',
        content = content;

  Map<String, String> toMap() => {'role': role, 'content': content};

  factory ChatMessage.fromMap(Map<String, String> map) => ChatMessage(
        role: map['role'] ?? '',
        content: map['content'] ?? '',
      );

  @override
  List<Object?> get props => [role, content];
}
