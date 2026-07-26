import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class TabBarShimmer extends StatelessWidget {
  final int itemCount;
  final double height;
  final double tabWidth;
  final double tabHeight;
  final double borderRadius;

  const TabBarShimmer({
    super.key,
    this.itemCount = 6,
    this.height = 40,
    this.tabWidth = 70,
    this.tabHeight = 30,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, _) => AppShimmer(
          child: Container(
            width: tabWidth,
            height: tabHeight,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
