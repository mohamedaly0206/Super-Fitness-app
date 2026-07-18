import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';

class ForgetPasswordHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  const ForgetPasswordHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              getRegularStyle(
                context: context,
                fontSize: FontSizeManager.s18,
                color: AppColors.textPrimary,
              ),
        ),
        Text(
          subtitle,
          style:
              subtitleStyle ??
              getBoldStyle(
                context: context,
                fontSize: FontSizeManager.s24,
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
