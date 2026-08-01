import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.height,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? AppSize.s50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSize.borderRadiusButton,
          ),
        ),
        padding: padding,
      ),
      child: Text(
        text,
        style: getSemiBoldStyle(context: context, color: AppColors.surface),
      ),
    );
  }
}
