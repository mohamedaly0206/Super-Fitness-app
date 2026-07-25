import 'package:flutter/material.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

import 'exercise_video_bottom_sheet.dart';

Future<void> showExerciseVideo(BuildContext context, ExerciseEntity exercise) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ExerciseVideoBottomSheet(exercise: exercise),
      );
    },
  );
}
