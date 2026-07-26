import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
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
        height: AppSize.s30,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getMediumStyle(
            context: context,
            color: AppColors.textWhite,
            fontSize: FontSizeManager.s12,
          ),
        ),
      ),
    );
  }
}
