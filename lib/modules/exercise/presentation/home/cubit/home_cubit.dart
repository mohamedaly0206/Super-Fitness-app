import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_all_muscles_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_exercises_by_muscle_and_difficulty_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_levels_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_muscles_by_muscle_group_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_random_muscles_use_case.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_event.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/use_cases/get_categories_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetLevelsUseCase getLevelsUseCase;
  final GetExercisesByMuscleAndDifficultyUseCase
  getExercisesByMuscleAndDifficultyUseCase;
  final GetRandomMusclesUseCase getRandomMusclesUseCase;
  final GetAllMusclesUseCase getAllMusclesUseCase;
  final GetMusclesByMuscleGroupUseCase getMusclesByMuscleGroupUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit({
    required this.getLevelsUseCase,
    required this.getExercisesByMuscleAndDifficultyUseCase,
    required this.getRandomMusclesUseCase,
    required this.getAllMusclesUseCase,
    required this.getMusclesByMuscleGroupUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeState());

  void doEvent(HomeEvent event) {
    switch (event) {
      case GetExerciseByMuscleAndDifficultyEvent():
        _getExercisesByMuscleAndDifficulty(event.page);
      case GetLevelsEvent():
        _getLevels();
      case GetRandomMusclesEvent():
        _getRandomMuscles();
      case GetMuscleGroupsEvent():
        _getMuscleGroups();
      case GetMusclesByGroupEvent():
        _getMusclesByGroup(event.muscleGroupId);
      case GetFoodCategoriesEvent():
        _getFoodCategories();
    }
  }

  void loadMoreExercises() {
    if (state.exerciseState.isLoading) return;
    if (state.currentPage >= state.totalPages) return;
    _getExercisesByMuscleAndDifficulty(state.currentPage + 1);
  }

  bool get canLoadMore =>
      !state.exerciseState.isLoading && state.currentPage < state.totalPages;

  void _getLevels() async {
    emit(
      state.copyWith(
        levelState: state.levelState.copyWith(isLoadingParam: true),
      ),
    );
    final response = await getLevelsUseCase.call();
    switch (response) {
      case SuccessBaseResponse<List<LevelEntity>>():
        emit(
          state.copyWith(
            levelState: state.levelState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
        _tryFetchExercises();
      case ErrorBaseResponse<List<LevelEntity>>():
        emit(
          state.copyWith(
            levelState: state.levelState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }

  void _getRandomMuscles() async {
    emit(
      state.copyWith(
        musclesState: state.musclesState.copyWith(isLoadingParam: true),
      ),
    );
    final response = await getRandomMusclesUseCase.call();
    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        emit(
          state.copyWith(
            musclesState: state.musclesState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
        _tryFetchExercises();
      case ErrorBaseResponse<List<MuscleEntity>>():
        emit(
          state.copyWith(
            musclesState: state.musclesState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }

  void _getMuscleGroups() async {
    emit(
      state.copyWith(
        muscleGroupsState: state.muscleGroupsState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await getAllMusclesUseCase();
    switch (response) {
      case SuccessBaseResponse<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            muscleGroupsState: state.muscleGroupsState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
        if (response.data.isNotEmpty) {
          _getMusclesByGroup(response.data.first.id);
        }
      case ErrorBaseResponse<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            muscleGroupsState: state.muscleGroupsState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }

  void _getMusclesByGroup(String muscleGroupId) async {
    emit(
      state.copyWith(
        musclesByGroupState: state.musclesByGroupState.copyWith(
          isLoadingParam: true,
        ),
        selectedMuscleGroupId: muscleGroupId,
      ),
    );
    final response = await getMusclesByMuscleGroupUseCase(
      muscleGroupId: muscleGroupId,
    );
    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        emit(
          state.copyWith(
            musclesByGroupState: state.musclesByGroupState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<MuscleEntity>>():
        emit(
          state.copyWith(
            musclesByGroupState: state.musclesByGroupState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
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

    if (levels == null ||
        levels.isEmpty ||
        muscles == null ||
        muscles.isEmpty) {
      return;
    }

    final firstLevelId = levels.first.id;
    final firstMuscleId = muscles.first.id;

    final isFirstPage = page == 1;

    emit(
      state.copyWith(
        exerciseState: state.exerciseState.copyWith(isLoadingParam: true),
        currentPage: page,
      ),
    );

    final response = await getExercisesByMuscleAndDifficultyUseCase.call(
      primeMoverMuscleId: firstMuscleId,
      difficultyLevelId: firstLevelId,
      page: page,
    );

    switch (response) {
      case SuccessBaseResponse<ExercisesPaginatedResponse>():
        final paginated = response.data;
        final existingExercises = isFirstPage
            ? <ExerciseEntity>[]
            : (state.exerciseState.data ?? []);
        emit(
          state.copyWith(
            exerciseState: state.exerciseState.copyWith(
              isLoadingParam: false,
              dataParam: [...existingExercises, ...paginated.exercises],
            ),
            currentPage: paginated.currentPage,
            totalPages: paginated.totalPages,
          ),
        );
      case ErrorBaseResponse<ExercisesPaginatedResponse>():
        emit(
          state.copyWith(
            exerciseState: state.exerciseState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }

  void _getFoodCategories() async {
    emit(
      state.copyWith(
        foodCategoriesState: state.foodCategoriesState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await getCategoriesUseCase();
    switch (response) {
      case SuccessBaseResponse<List<MealCategoryEntity>>():
        emit(
          state.copyWith(
            foodCategoriesState: state.foodCategoriesState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<MealCategoryEntity>>():
        emit(
          state.copyWith(
            foodCategoriesState: state.foodCategoriesState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.failure.message,
            ),
          ),
        );
    }
  }
}
