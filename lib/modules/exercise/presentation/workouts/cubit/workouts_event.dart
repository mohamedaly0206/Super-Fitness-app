sealed class WorkoutsEvent {}

class GetMuscleGroupsEvent extends WorkoutsEvent {}

class GetMusclesByGroupEvent extends WorkoutsEvent {
  final String muscleGroupId;
  GetMusclesByGroupEvent({required this.muscleGroupId});
}