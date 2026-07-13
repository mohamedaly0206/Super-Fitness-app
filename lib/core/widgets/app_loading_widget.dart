import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const AppLoadingWidget({
    super.key,
    this.size = AppSize.s30,
    this.strokeWidth = AppSize.s3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
        ),
      ),
    );
  }
}
