import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_event.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<OnboardingCubit>().doEvent(const SkipPressedEvent());
      },
      child: Text(
        'Skip',
        style: getMediumStyle(context: context, color: AppColors.surface),
      ),
    );
  }
}
