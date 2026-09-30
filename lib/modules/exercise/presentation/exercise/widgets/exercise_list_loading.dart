import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';

import 'exercise_card_shimmer.dart';

class ExerciseListLoading extends StatelessWidget {
  const ExerciseListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: AppPadding.p10,
        right: AppPadding.p10,
        top: 0,
        bottom: 0,
      ),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: AppSize.s5),
      itemBuilder: (_, __) => const ExerciseCardShimmer(),
    );
  }
}
