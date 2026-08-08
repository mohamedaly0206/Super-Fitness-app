import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/font_size_manager.dart';
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

  TextStyle getRegularStyle2({
    double fontSize = FontSizeManager.s14,
    FontWeight fontWeight = FontWeightManager.regular,
    FontStyle fontStyle = FontStyle.normal,
    required Color color,
  }) {
    return GoogleFonts.balooThambi2(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  MarkdownStyleSheet get _styleSheet => MarkdownStyleSheet(
    p: getRegularStyle2(
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s16,
    ),
    h1: getRegularStyle2(
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s24,
      fontWeight: FontWeightManager.bold,
    ),
    h2: getRegularStyle2(
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s20,
      fontWeight: FontWeightManager.bold,
    ),
    h3: getRegularStyle2(
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s18,
      fontWeight: FontWeightManager.semiBold,
    ),
    strong: getRegularStyle2(
      color: AppColors.textPrimary,
      fontSize: FontSizeManager.s16,
      fontWeight: FontWeightManager.bold,
    ),
    em: getRegularStyle2(
      color: AppColors.textSecondary,
      fontSize: FontSizeManager.s16,
      fontStyle: FontStyle.italic,
    ),
    blockquote: getRegularStyle2(
      color: AppColors.textSecondary,
      fontSize: FontSizeManager.s14,
      fontStyle: FontStyle.italic,
    ),
    code: getRegularStyle2(
      color: AppColors.primary,
      fontSize: FontSizeManager.s14,
    ),
    listBullet: getRegularStyle2(
      color: AppColors.primary,
      fontSize: FontSizeManager.s16,
    ),
  );

  Widget _buildImage(Uri uri, String? title, String? alt) {
    if (uri.scheme == 'data') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          uri.data!.contentAsBytes(),
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const _ImageError(),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        uri.toString(),
        fit: BoxFit.contain,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (_, __, ___) => const _ImageError(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('h:mm a').format(message.createdAt);

    return GestureDetector(
      onLongPress: onCopy,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? AppColors.chatGlassPrimaryFill
              : AppColors.chatGlassFill,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUser ? 20 : 6),
            topRight: Radius.circular(isUser ? 6 : 20),
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
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
              imageBuilder: _buildImage,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: getRegularStyle2(
                  color: AppColors.textPrimary.withValues(alpha: .45),
                  fontSize: FontSizeManager.s10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white38,
          size: 32,
        ),
      ),
    );
  }
}
