import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_card_shimmer.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_list_loading.dart';

class ExerciseScreenLoading extends StatelessWidget {
  const ExerciseScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ExerciseCardShimmer(),
        AppSizedBox(height: 10),
        Expanded(child: ExerciseListLoading()),
      ],
    );
  }
}
