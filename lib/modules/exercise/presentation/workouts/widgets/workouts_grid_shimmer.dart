import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';

class WorkoutsGridShimmer extends StatelessWidget {
  const WorkoutsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppPadding.p12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSize.s12,
        mainAxisSpacing: AppSize.s12,
        childAspectRatio: 1.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => AppShimmer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSize.borderRadiusSnackBar),
          ),
        ),
      ),
    );
  }
}
