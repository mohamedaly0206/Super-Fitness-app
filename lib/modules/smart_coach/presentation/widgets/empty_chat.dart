import 'package:flutter/material.dart';

class EmptyChatView extends StatelessWidget {
  const EmptyChatView({super.key});
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight + 20;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: topPadding),

          const Text(
            "Hi Ahmed",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 4),

          const Text(
            "I Am Your Smart Coach",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          Hero(
            tag: "robot",
            child: Image.asset(
              "assets/images/Robot.png",
              height: 330,
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          const Text(
            "How Can I Assist You\nToday?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
