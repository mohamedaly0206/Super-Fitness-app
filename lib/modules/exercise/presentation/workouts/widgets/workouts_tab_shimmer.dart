import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class WorkoutsTabShimmer extends StatelessWidget {
  const WorkoutsTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, _) => AppShimmer(
          child: Container(
            width: 60,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
