import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_exercises_by_muscle_and_difficulty_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_levels_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_random_muscles_use_case.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_event.dart';

part 'home_state.dart';


@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  final GetLevelsUseCase getLevelsUseCase;
  final GetExercisesByMuscleAndDifficultyUseCase
  getExercisesByMuscleAndDifficultyUseCase;
  final GetRandomMusclesUseCase getRandomMusclesUseCase;
  HomeCubit({
    required this.getLevelsUseCase,
    required this.getExercisesByMuscleAndDifficultyUseCase,
    required this.getRandomMusclesUseCase,
  }) : super(HomeState());

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetExerciseByMuscleAndDifficultyEvent():
        _getExercisesByMuscleAndDifficulty(event.page);
      case GetLevelsEvent():
        _getLevels();
      case GetRandomMusclesEvent():
        _getRandomMuscles();
    }
  }

  void loadMoreExercises() {
    if (state.exerciseState.isLoading) return;
    if (state.currentPage >= state.totalPages) return;
    _getExercisesByMuscleAndDifficulty(state.currentPage + 1);
  }

  bool get canLoadMore => !state.exerciseState.isLoading && state.currentPage < state.totalPages;

  void _getLevels() async {
    emit(state.copyWith(levelState: state.levelState.copyWith(isLoadingParam: true)));
    final response = await getLevelsUseCase.call();
    switch (response) {
      case SuccessBaseResponse<List<LevelEntity>>():
        emit(state.copyWith(
          levelState: state.levelState.copyWith(
            isLoadingParam: false,
            dataParam: response.data,
          ),
        ));
        _tryFetchExercises();
      case ErrorBaseResponse<List<LevelEntity>>():
        emit(state.copyWith(
          levelState: state.levelState.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.failure.message,
          ),
        ));
    }
  }

  void _getRandomMuscles() async {
    emit(state.copyWith(musclesState: state.musclesState.copyWith(isLoadingParam: true)));
    final response = await getRandomMusclesUseCase.call();
    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        emit(state.copyWith(
          musclesState: state.musclesState.copyWith(
            isLoadingParam: false,
            dataParam: response.data,
          ),
        ));
        _tryFetchExercises();
      case ErrorBaseResponse<List<MuscleEntity>>():
        emit(state.copyWith(
          musclesState: state.musclesState.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.failure.message,
          ),
        ));
    }
  }

  void _tryFetchExercises() {
    if (state.musclesState.data != null &&
        state.musclesState.data!.isNotEmpty &&
        state.levelState.data != null &&
        state.levelState.data!.isNotEmpty) {
      _getExercisesByMuscleAndDifficulty(1);
    }
  }

  void _getExercisesByMuscleAndDifficulty(int page) async {
    final levels = state.levelState.data;
    final muscles = state.musclesState.data;

    if (levels == null || levels.isEmpty || muscles == null || muscles.isEmpty) return;

    final firstLevelId = levels.first.id;
    final firstMuscleId = muscles.first.id;

    final isFirstPage = page == 1;

    emit(state.copyWith(
      exerciseState: state.exerciseState.copyWith(isLoadingParam: true),
      currentPage: page,
    ));

    final response = await getExercisesByMuscleAndDifficultyUseCase.call(primeMoverMuscleId: firstMuscleId, difficultyLevelId: firstLevelId, page: page);

    switch (response) {
      case SuccessBaseResponse<ExercisesPaginatedResponse>():
        final paginated = response.data;
        final existingExercises = isFirstPage ? <ExerciseEntity>[] : (state.exerciseState.data ?? []);
        emit(state.copyWith(
          exerciseState: state.exerciseState.copyWith(
            isLoadingParam: false,
            dataParam: [...existingExercises, ...paginated.exercises],
          ),
          currentPage: paginated.currentPage,
          totalPages: paginated.totalPages,
        ));
      case ErrorBaseResponse<ExercisesPaginatedResponse>():
        emit(state.copyWith(
          exerciseState: state.exerciseState.copyWith(
            isLoadingParam: false,
            errorMessageParam: response.failure.message,
          ),
        ));
    }
  }
}
