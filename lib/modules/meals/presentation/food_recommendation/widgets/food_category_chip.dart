import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class FoodCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FoodCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.navBarAnimation,
        height: AppSize.s50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusPill),
        ),
        child: AnimatedDefaultTextStyle(
          duration: AppDurations.navBarAnimation,
          curve: Curves.easeInOut,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSizeManager.s14,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
