import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

Widget sectionShimmer() {
  return CustomContainer(
    color: AppColors.grey2,
    height: 131,
    width: double.infinity,
    child: AppShimmer(
      child: Container(
        height: 131,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}