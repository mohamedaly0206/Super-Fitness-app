import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

sealed class ExerciseIntent extends Equatable {
  const ExerciseIntent();

  @override
  List<Object?> get props => [];
}

/// أول ما الشاشة تفتح
class LoadExerciseScreenIntent extends ExerciseIntent {
  final String primeMoverMuscleId;

  const LoadExerciseScreenIntent({required this.primeMoverMuscleId});

  @override
  List<Object?> get props => [primeMoverMuscleId];
}

/// اختيار Difficulty
class DifficultySelectedIntent extends ExerciseIntent {
  final DifficultyLevelEntity difficulty;

  const DifficultySelectedIntent({required this.difficulty});

  @override
  List<Object?> get props => [difficulty];
}

/// اختيار Exercise من الليست
class ExerciseSelectedIntent extends ExerciseIntent {
  final ExerciseEntity exercise;

  const ExerciseSelectedIntent({required this.exercise});

  @override
  List<Object?> get props => [exercise];
}

// class PlayVideoIntent extends ExerciseIntent {
//   const PlayVideoIntent();
// }

// class StopVideoIntent extends ExerciseIntent {
//   const StopVideoIntent();
// }
