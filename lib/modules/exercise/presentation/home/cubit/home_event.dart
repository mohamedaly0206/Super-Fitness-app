sealed class HomeEvent {}

class GetExerciseByMuscleAndDifficultyEvent extends HomeEvent {
  final int page;

  GetExerciseByMuscleAndDifficultyEvent({this.page = 1});
}

class GetLevelsEvent extends HomeEvent {}

class GetRandomMusclesEvent extends HomeEvent {}

class GetMuscleGroupsEvent extends HomeEvent {}

class GetMusclesByGroupEvent extends HomeEvent {
  final String muscleGroupId;
  GetMusclesByGroupEvent({required this.muscleGroupId});
}