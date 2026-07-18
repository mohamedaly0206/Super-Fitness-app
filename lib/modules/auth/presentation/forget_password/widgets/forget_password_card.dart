import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgetPasswordCard extends StatelessWidget {
  final Widget body;
  final Widget? footer;

  const ForgetPasswordCard({super.key, required this.body, this.footer});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 60),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black.withValues(alpha: .010),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    body,
                    if (footer != null) ...[
                      const SizedBox(height: 20),
                      footer!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fade(duration: 260.ms)
        .scale(
          begin: const Offset(.92, .92),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }
}
