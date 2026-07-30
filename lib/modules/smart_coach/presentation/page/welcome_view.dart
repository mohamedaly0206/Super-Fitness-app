import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_intent.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),

          Image.asset(
            "assets/images/Robot.png",
            width: 350,
            fit: BoxFit.contain,
          ),

          const Spacer(),

          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .08),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(36),
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "How Can I Assist You\nToday ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () {
                          context.read<SmartCoachCubit>().doIntent(
                            const CreateNewConversationIntent(),
                          );
                        },
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
