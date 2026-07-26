import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class GridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double borderRadius;

  const GridShimmer({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => AppShimmer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
