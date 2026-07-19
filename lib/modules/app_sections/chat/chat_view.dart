import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.chat,
      body: SafeArea(
        child: Center(
          child: Text(
            'Chat Screen',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
