import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary.withValues(alpha: 0.4),
      highlightColor: AppColors.primaryLight.withValues(alpha: 0.6),
      child: Container(
        width: double.infinity,
        height: AppSize.s38,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusButton),
        ),
      ),
    );
  }
}
