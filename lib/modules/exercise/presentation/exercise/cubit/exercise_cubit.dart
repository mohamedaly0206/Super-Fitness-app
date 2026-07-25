import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_difficulty_levels_by_prime_mover_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_exercises_by_prime_mover_and_difficulty_use_case.dart';

import 'exercise_intent.dart';
import 'exercise_state.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final GetDifficultyLevelsByPrimeMoverUseCase _getDifficultyLevelsUseCase;

  final GetExercisesByPrimeMoverAndDifficultyUseCase _getExercisesUseCase;

  ExerciseCubit(this._getDifficultyLevelsUseCase, this._getExercisesUseCase)
    : super(const ExerciseState());

  late final String _primeMoverMuscleId;

  Future<void> doIntent(ExerciseIntent intent) async {
    switch (intent) {
      case LoadExerciseScreenIntent():
        _primeMoverMuscleId = intent.primeMoverMuscleId;
        await _loadDifficultyLevels();

      case DifficultySelectedIntent():
        if (state.selectedDifficulty?.id == intent.difficulty.id) return;

        emit(state.copyWith(selectedDifficulty: intent.difficulty));

        await _loadExercises(difficultyId: intent.difficulty.id);

      case ExerciseSelectedIntent():
        if (state.selectedExercise?.id == intent.exercise.id) return;

        emit(state.copyWith(selectedExercise: intent.exercise));
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
