import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

Widget homeTabShimmer() {
  return SizedBox(
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: 10),
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
