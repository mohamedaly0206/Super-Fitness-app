import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

import '../../domain/entities/message_role.dart';

class ChatAvatar extends StatelessWidget {
  final MessageRole role;
  final String? userImageUrl;

  const ChatAvatar({super.key, required this.role, this.userImageUrl});

  @override
  Widget build(BuildContext context) {
    final isUser = role == MessageRole.user;

    Widget child;
    if (isUser && userImageUrl != null && userImageUrl!.isNotEmpty) {
      child = Image.network(
        userImageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Image.asset(AppPng.user, fit: BoxFit.cover),
      );
    } else if (isUser) {
      child = Image.asset(AppPng.user, fit: BoxFit.cover);
    } else {
      child = Image.asset(AppPng.coach, fit: BoxFit.cover);
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isUser
            ? null
            : [
                BoxShadow(
                  color: AppColors.chatGlassPrimaryFill.withValues(alpha: .60),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s42 / 2),
        child: SizedBox(width: AppSize.s42, height: AppSize.s42, child: child),
      ),
    );
  }
}
