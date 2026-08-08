import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

import '../../domain/entities/message_role.dart';
import 'chat_avatar.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChatAvatar(role: MessageRole.assistant),

          const AppSizedBox(width: 10),

          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.chatGlassFill,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
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
