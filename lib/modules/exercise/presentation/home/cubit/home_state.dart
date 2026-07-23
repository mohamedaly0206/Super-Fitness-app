part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BaseState<List<LevelEntity>> levelState;
  final BaseState<List<ExerciseEntity>> exerciseState;
  final BaseState<List<MuscleEntity>> musclesState;
  final BaseState<List<MuscleGroupEntity>> muscleGroupsState;
  final BaseState<List<MuscleEntity>> musclesByGroupState;
  final String? selectedMuscleGroupId;
  final int currentPage;
  final int totalPages;

  const HomeState({
    this.levelState = const BaseState<List<LevelEntity>>(),
    this.exerciseState = const BaseState<List<ExerciseEntity>>(),
    this.musclesState = const BaseState<List<MuscleEntity>>(),
    this.muscleGroupsState = const BaseState<List<MuscleGroupEntity>>(),
    this.musclesByGroupState = const BaseState<List<MuscleEntity>>(),
    this.selectedMuscleGroupId,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  HomeState copyWith({
    BaseState<List<LevelEntity>>? levelState,
    BaseState<List<ExerciseEntity>>? exerciseState,
    BaseState<List<MuscleEntity>>? musclesState,
    BaseState<List<MuscleGroupEntity>>? muscleGroupsState,
    BaseState<List<MuscleEntity>>? musclesByGroupState,
    String? selectedMuscleGroupId,
    int? currentPage,
    int? totalPages,
  }) {
    return HomeState(
      levelState: levelState ?? this.levelState,
      exerciseState: exerciseState ?? this.exerciseState,
      musclesState: musclesState ?? this.musclesState,
      muscleGroupsState: muscleGroupsState ?? this.muscleGroupsState,
      musclesByGroupState: musclesByGroupState ?? this.musclesByGroupState,
      selectedMuscleGroupId: selectedMuscleGroupId ?? this.selectedMuscleGroupId,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [
        levelState,
        exerciseState,
        musclesState,
        muscleGroupsState,
        musclesByGroupState,
        ? selectedMuscleGroupId,
        currentPage,
        totalPages,
      ];
}