import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final double exactProgress;
  final int totalSteps;
  final Color activeColor;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.exactProgress,
    required this.totalSteps,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: AppSize.s42,
      width: AppSize.s42,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: exactProgress,
            strokeWidth: 4,
            backgroundColor: theme.colorScheme.primaryContainer,
            valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          ),
          Center(
            child: Text(
              "$currentStep/$totalSteps",
              style: getMediumStyle(
                context: context,
                color: theme.colorScheme.onPrimary,
                fontSize: FontSizeManager.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
