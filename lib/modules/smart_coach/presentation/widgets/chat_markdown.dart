import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class ChatMarkdown extends StatelessWidget {
  final String text;

  const ChatMarkdown({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      selectable: true,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 15,
          height: 1.5,
        ),

        h1: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),

        h2: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),

        h3: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),

        strong: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),

        em: const TextStyle(
          color: AppColors.textSecondary,
          fontStyle: FontStyle.italic,
        ),

        blockquote: const TextStyle(
          color: AppColors.textSecondary,
          fontStyle: FontStyle.italic,
        ),

        code: const TextStyle(
          fontFamily: 'monospace',
          color: AppColors.primary,
        ),

        listBullet: const TextStyle(color: AppColors.primary, fontSize: 16),
      ),
    );
  }
}
