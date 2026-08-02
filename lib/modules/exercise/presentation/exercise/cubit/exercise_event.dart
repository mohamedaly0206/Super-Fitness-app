import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

sealed class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

/// أول ما الشاشة تفتح
class LoadExerciseScreenEvent extends ExerciseEvent {
  final String primeMoverMuscleId;

  const LoadExerciseScreenEvent({required this.primeMoverMuscleId});

  @override
  List<Object?> get props => [primeMoverMuscleId];
}

/// اختيار Difficulty
class DifficultySelectedEvent extends ExerciseEvent {
  final DifficultyLevelEntity difficulty;

  const DifficultySelectedEvent({required this.difficulty});

  @override
  List<Object?> get props => [difficulty];
}

/// اختيار Exercise من الليست
class ExerciseSelectedEvent extends ExerciseEvent {
  final ExerciseEntity exercise;

  const ExerciseSelectedEvent({required this.exercise});

  @override
  List<Object?> get props => [exercise];
}

// class PlayVideoEvent extends ExerciseEvent {
//   const PlayVideoEvent();
// }

// class StopVideoEvent extends ExerciseEvent {
//   const StopVideoEvent();
// }
