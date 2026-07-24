import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

Widget homeTabShimmer() {
  return SizedBox(
    height: AppSize.s40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: AppSize.s10),
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
