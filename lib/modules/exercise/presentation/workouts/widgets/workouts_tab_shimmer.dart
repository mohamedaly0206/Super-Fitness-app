import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class WorkoutsTabShimmer extends StatelessWidget {
  const WorkoutsTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(width: AppSize.s8),
        itemBuilder: (_, _) => AppShimmer(
          child: Container(
            width: AppSize.s60,
            height: AppSize.s28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSize.borderRadiusPill),
            ),
          ),
        ),
      ),
    );
  }
}
