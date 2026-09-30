import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: AppDurations.shimmerPeriod,
      baseColor: AppColors.grey600.withAlpha(60),
      highlightColor: AppColors.background,
      child: child,
    );
  }
}
