import 'package:equatable/equatable.dart';

import 'conversation.dart';
import 'message.dart';

class ChatSession extends Equatable {
  final Conversation conversation;
  final List<Message> messages;

  const ChatSession({required this.conversation, this.messages = const []});

  ChatSession copyWith({Conversation? conversation, List<Message>? messages}) {
    return ChatSession(
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [conversation, messages];
}
