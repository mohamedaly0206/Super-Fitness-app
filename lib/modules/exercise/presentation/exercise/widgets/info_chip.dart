import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class InfoChip extends StatelessWidget {
  final String text;
  final bool isFilled;
  final Color? filledColor;
  final Color? textColor;

  const InfoChip({
    super.key,
    required this.text,
    this.isFilled = false,
    this.filledColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isFilled
        ? (filledColor ?? AppColors.primary)
        : Colors.transparent;

    final foregroundColor =
        textColor ?? (isFilled ? AppColors.textPrimary : AppColors.textPrimary);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: isFilled ? null : Border.all(color: AppColors.textSecondary),
      ),
      child: Text(
        text,
        style: getSemiBoldStyle(
          context: context,
          fontSize: 14,
          color: foregroundColor,
        ),
      ),
    );
  }
}
