part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BaseState<List<LevelEntity>> levelState;
  final BaseState<List<ExerciseEntity>> exerciseState;
  final BaseState<List<MuscleEntity>> musclesState;
  final int currentPage;
  final int totalPages;

  const HomeState({
    this.levelState = const BaseState<List<LevelEntity>>(),
    this.exerciseState = const BaseState<List<ExerciseEntity>>(),
    this.musclesState = const BaseState<List<MuscleEntity>>(),
    this.currentPage = 1,
    this.totalPages = 1,
  });

  HomeState copyWith({
    BaseState<List<LevelEntity>>? levelState,
    BaseState<List<ExerciseEntity>>? exerciseState,
    BaseState<List<MuscleEntity>>? musclesState,
    int? currentPage,
    int? totalPages,
  }) {
    return HomeState(
      levelState: levelState ?? this.levelState,
      exerciseState: exerciseState ?? this.exerciseState,
      musclesState: musclesState ?? this.musclesState,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props =>
      [levelState, exerciseState, musclesState, currentPage, totalPages];
}
