import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_difficulty_levels_by_prime_mover_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_exercises_by_prime_mover_and_difficulty_use_case.dart';

import 'exercise_event.dart';
import 'exercise_state.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final GetDifficultyLevelsByPrimeMoverUseCase _getDifficultyLevelsUseCase;

  final GetExercisesByPrimeMoverAndDifficultyUseCase _getExercisesUseCase;

  ExerciseCubit(this._getDifficultyLevelsUseCase, this._getExercisesUseCase)
    : super(const ExerciseState());

  late final String _primeMoverMuscleId;

  Future<void> doEvent(ExerciseEvent event) async {
    switch (event) {
      case LoadExerciseScreenEvent():
        _primeMoverMuscleId = event.primeMoverMuscleId;
        await _loadDifficultyLevels();

      case DifficultySelectedEvent():
        if (state.selectedDifficulty?.id == event.difficulty.id) return;

        emit(state.copyWith(selectedDifficulty: event.difficulty));

        await _loadExercises(difficultyId: event.difficulty.id);

      case ExerciseSelectedEvent():
        if (state.selectedExercise?.id == event.exercise.id) return;

        emit(state.copyWith(selectedExercise: event.exercise));
    }
  }

  Future<void> _loadDifficultyLevels() async {
    emit(
      state.copyWith(
        baseState: state.baseState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    final response = await _getDifficultyLevelsUseCase(_primeMoverMuscleId);

    switch (response) {
      case SuccessBaseResponse():
        final levels = response.data.difficultyLevels;

        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(isLoadingParam: false),
            difficultyLevels: levels,
            selectedDifficulty: levels.isEmpty ? null : levels.first,
          ),
        );

        if (levels.isNotEmpty) {
          await _loadExercises(
            difficultyId: levels.first.id,
            showLoading: false,
          );
        }

      case ErrorBaseResponse():
        emit(
          state.copyWith(
            baseState: state.baseState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }

  Future<void> _loadExercises({
    required String difficultyId,
    bool showLoading = true,
  }) async {
    if (showLoading) {
      emit(state.copyWith(isLoadingExercises: true));
    }

    final response = await _getExercisesUseCase(
      primeMoverMuscleId: _primeMoverMuscleId,
      difficultyLevelId: difficultyId,
    );

    switch (response) {
      case SuccessBaseResponse():
        final exercises = response.data.exercises;

        emit(
          state.copyWith(
            isLoadingExercises: false,
            exercises: exercises,
            selectedExercise: exercises.isEmpty ? null : exercises.first,
          ),
        );

      case ErrorBaseResponse():
        emit(
          state.copyWith(
            isLoadingExercises: false,
            baseState: state.baseState.copyWith(
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }
}
