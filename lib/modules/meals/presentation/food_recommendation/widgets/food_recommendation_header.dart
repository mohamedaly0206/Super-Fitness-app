import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';

class FoodRecommendationHeader extends StatelessWidget {
  const FoodRecommendationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p12,
      ),
      child: Row(
        children: [
          CustomBackButton(),
          const SizedBox(width: AppPadding.p16),
          Expanded(
            child: Text(
              AppStrings.foodRecommendation,
              style: getBoldStyle(
                context: context,
                color: AppColors.textWhite,
                fontSize: FontSizeManager.s22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
