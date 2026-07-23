import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppPadding.p16),
    this.margin,
    this.color,
    this.borderRadius = AppSize.borderRadiusCard,
    this.border,
    this.boxShadow,
    this.gradient,
    this.alignment,
    this.decoration,
    this.blur = 10,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;

  /// Background blur (same value as Figma)
  final double blur;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
      color: gradient == null ? (color ?? AppColors.glassFill) : null,
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: boxShadow,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
          tileMode: TileMode.decal,
        ),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: decoration ?? defaultDecoration,
          child: child,
        ),
      ),
    );
  }
}