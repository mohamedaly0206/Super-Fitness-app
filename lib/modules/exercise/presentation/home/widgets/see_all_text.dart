import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class SeeAllText extends StatelessWidget {
  final VoidCallback onTap;

  const SeeAllText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        context.seeAll,
        style:
            getMediumStyle(
              context: context,
              fontSize: FontSizeManager.s14,
              color: AppColors.primary,
            ).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
      ),
    );
  }
}
