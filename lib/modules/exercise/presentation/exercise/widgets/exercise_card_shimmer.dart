import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';

class ExerciseCardShimmer extends StatelessWidget {
  const ExerciseCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s16),
            child: const ImageShimmer(width: 90, height: 90),
          ),

          const SizedBox(width: AppSize.s12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageShimmer(
                  width: double.infinity,
                  height: AppSize.s18,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),

                const SizedBox(height: AppSize.s8),

                ImageShimmer(
                  width: 120,
                  height: AppSize.s14,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSize.s12),

          const ImageShimmer(
            width: 46,
            height: 46,
            borderRadius: BorderRadius.all(Radius.circular(23)),
          ),
        ],
      ),
    );
  }
}
