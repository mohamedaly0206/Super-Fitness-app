import 'package:flutter/material.dart';

import '../../domain/entities/message_role.dart';

class ChatAvatar extends StatelessWidget {
  final MessageRole role;

  const ChatAvatar({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final image = role == MessageRole.assistant
        ? 'assets/images/ai.png'
        : 'assets/images/man1.png';

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffFF6A00), width: 1.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipOval(child: Image.asset(image, fit: BoxFit.cover)),
      ),
    );
  }
}
