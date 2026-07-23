import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class WorkoutsGridShimmer extends StatelessWidget {
  const WorkoutsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => AppShimmer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
