import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';

class CustomScaffold extends StatelessWidget {
  final Backgrounds background;
  final PreferredSizeWidget? appBar;
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.background,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(background.background, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: AppColors.background.withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textPrimary.withValues(alpha: 0.08),
                  width: AppSize.borderWidth,
                ),
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}

enum Backgrounds {
  login(AppPng.loginAndRegisterBackground),
  register(AppPng.loginAndRegisterBackground),
  forgetPassword(AppPng.forgetPasswordBackground),
  weightAndGoalActivityEdit(AppPng.weightAndGoalActivityEditBackground),
  onboarding(AppPng.onboardingBackground),
  profileAndEdit(AppPng.profileAndEditBackground),
  homeAndSelectDetailsExercise(AppPng.homeAndSelectDetailsExerciseBackground),
  chat(AppPng.chatBackground);

  final String background;
  const Backgrounds(this.background);
}
