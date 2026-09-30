import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';

import '../../domain/entities/message.dart';
import '../../domain/entities/message_role.dart';
import 'chat_avatar.dart';
import 'message_content.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  final String? userImageUrl;

  const MessageBubble({super.key, required this.message, this.userImageUrl});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool visible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          visible = true;
        });
      }
    });
  }

  Future<void> copy() async {
    await Clipboard.setData(ClipboardData(text: widget.message.content));

    if (!mounted) return;

    CustomSnackBar.copied(context);
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.role == MessageRole.user;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      offset: visible ? Offset.zero : const Offset(0, .2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: visible ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isUser) ...[
                const ChatAvatar(role: MessageRole.assistant),
                const SizedBox(width: 10),
              ],

              Flexible(
                child: MessageContent(
                  message: widget.message,
                  isUser: isUser,
                  onCopy: copy,
                ),
              ),

              if (isUser) ...[
                const SizedBox(width: 10),
                ChatAvatar(
                  role: MessageRole.user,
                  userImageUrl: widget.userImageUrl,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
