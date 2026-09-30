import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Backgrounds background;

  final PreferredSizeWidget? appBar;

  final Widget? overlayAppBar;

  final Widget? endDrawer;

  final Widget body;

  final bool extendBehindAppBar;

  const CustomScaffold({
    super.key,
    required this.background,
    required this.body,
    this.appBar,
    this.overlayAppBar,
    this.endDrawer,
    this.extendBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBehindAppBar,
      appBar: overlayAppBar == null ? appBar : null,
      endDrawer: endDrawer,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(background.background, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: AppColors.background.withValues(alpha: .10),
              ),
            ),
          ),
          body,
          if (overlayAppBar != null)
            Positioned(top: 0, left: 0, right: 0, child: overlayAppBar!),
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
