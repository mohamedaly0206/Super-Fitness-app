import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';

class MealsGridShimmer extends StatelessWidget {
  const MealsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppPadding.p16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.s16,
        crossAxisSpacing: AppSize.s16,
        childAspectRatio: 1.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ImageShimmer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.circular(AppSize.borderRadiusCard),
        );
      },
    );
  }
}
