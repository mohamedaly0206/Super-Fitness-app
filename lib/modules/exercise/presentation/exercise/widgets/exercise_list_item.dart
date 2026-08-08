import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

import '../cubit/exercise_cubit.dart';
import '../cubit/exercise_event.dart';
import 'exercise_card.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseEntity exercise;
  final void Function(ExerciseEntity exercise) onPlayVideo;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.onPlayVideo,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExerciseCubit>();

    final isSelected = context.select(
      (ExerciseCubit cubit) => cubit.state.selectedExercise?.id == exercise.id,
    );

    return ExerciseCard(
      exercise: exercise,
      isSelected: isSelected,
      onTap: () {
        cubit.doEvent(ExerciseSelectedEvent(exercise: exercise));
      },
      onPlay: () {
        cubit.doEvent(ExerciseSelectedEvent(exercise: exercise));
        onPlayVideo(exercise);
      },
    );
  }
}
