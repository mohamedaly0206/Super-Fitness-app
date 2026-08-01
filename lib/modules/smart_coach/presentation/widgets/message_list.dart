import 'package:flutter/material.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/message.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/message_bubble.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/typing_indicator.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final ScrollController controller;
  final bool isTyping;
  final String? userImageUrl;

  const MessageList({
    super.key,
    required this.messages,
    required this.controller,
    required this.isTyping,
    this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 25,
        16,
        20,
      ),
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: TypingIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MessageBubble(
            key: ValueKey(messages[index].id),
            message: messages[index],
            userImageUrl: userImageUrl,
          ),
        );
      },
    );
  }
}
