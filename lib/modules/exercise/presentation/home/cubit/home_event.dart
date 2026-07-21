sealed class HomeEvent {}

class GetExerciseByMuscleAndDifficultyEvent extends HomeEvent {
  final int page;

  GetExerciseByMuscleAndDifficultyEvent({this.page = 1});
}

class GetLevelsEvent extends HomeEvent {}

class GetRandomMusclesEvent extends HomeEvent {}
