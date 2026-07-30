import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

import '../../domain/entities/message_role.dart';
import 'chat_avatar.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const ChatAvatar(role: MessageRole.assistant),

          const SizedBox(width: 10),

          Container(
            width: 90,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.glassFill,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Lottie.asset(
                'assets/lottie/Typing.json',
                width: 48,
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
