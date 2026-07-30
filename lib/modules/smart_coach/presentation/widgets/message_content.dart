import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/message.dart';

class MessageContent extends StatelessWidget {
  final Message message;
  final bool isUser;
  final VoidCallback onCopy;

  const MessageContent({
    super.key,
    required this.message,
    required this.isUser,
    required this.onCopy,
  });

  MarkdownStyleSheet get _styleSheet => MarkdownStyleSheet(
    p: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
    h1: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    h2: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    h3: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    strong: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    em: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
    blockquote: const TextStyle(
      color: Colors.white70,
      fontStyle: FontStyle.italic,
    ),
    code: const TextStyle(color: AppColors.primary, fontFamily: 'monospace'),
    listBullet: const TextStyle(color: AppColors.primary),
  );

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('h:mm a').format(message.createdAt);

    return GestureDetector(
      onLongPress: onCopy,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser ? AppColors.glassPrimaryFill : AppColors.glassFill,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownBody(
              data: message.content,
              selectable: true,
              shrinkWrap: true,
              styleSheet: _styleSheet,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .45),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
