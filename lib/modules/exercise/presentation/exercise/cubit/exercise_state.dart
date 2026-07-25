import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

class ExerciseState extends Equatable {
  final BaseState<void> baseState;

  /// Difficulty Levels
  final List<DifficultyLevelEntity> difficultyLevels;
  final DifficultyLevelEntity? selectedDifficulty;

  /// Exercises
  final List<ExerciseEntity> exercises;
  final ExerciseEntity? selectedExercise;

  /// Loading
  final bool isFirstLoad;
  final bool isLoadingExercises;

  const ExerciseState({
    this.baseState = const BaseState<void>(),
    this.difficultyLevels = const [],
    this.selectedDifficulty,
    this.exercises = const [],
    this.selectedExercise,
    this.isFirstLoad = true,
    this.isLoadingExercises = false,
  });

  ExerciseState copyWith({
    BaseState<void>? baseState,
    List<DifficultyLevelEntity>? difficultyLevels,
    DifficultyLevelEntity? selectedDifficulty,
    List<ExerciseEntity>? exercises,
    ExerciseEntity? selectedExercise,
    bool? isFirstLoad,
    bool? isLoadingExercises,
  }) {
    return ExerciseState(
      baseState: baseState ?? this.baseState,
      difficultyLevels: difficultyLevels ?? this.difficultyLevels,
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
      exercises: exercises ?? this.exercises,
      selectedExercise: selectedExercise ?? this.selectedExercise,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      isLoadingExercises: isLoadingExercises ?? this.isLoadingExercises,
    );
  }

  @override
  List<Object?> get props => [
    baseState,
    difficultyLevels,
    selectedDifficulty,
    exercises,
    selectedExercise,
    isFirstLoad,
    isLoadingExercises,
  ];
}
