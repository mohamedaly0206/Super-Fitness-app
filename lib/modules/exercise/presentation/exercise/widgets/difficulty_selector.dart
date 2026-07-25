import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/cubit/exercise_intent.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/difficulty_chip.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final difficulties = context.select(
      (ExerciseCubit cubit) => cubit.state.difficultyLevels,
    );

    final selected = context.select(
      (ExerciseCubit cubit) => cubit.state.selectedDifficulty,
    );

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: difficulties.length,
        separatorBuilder: (_, __) => const AppSizedBox(width: 10),
        itemBuilder: (context, index) {
          final difficulty = difficulties[index];
          final isSelected = selected?.id == difficulty.id;

          return DifficultyChip(
            title: difficulty.name,
            isSelected: isSelected,
            onTap: () {
              context.read<ExerciseCubit>().doIntent(
                DifficultySelectedIntent(difficulty: difficulty),
              );
            },
          );
        },
      ),
    );
  }
}
