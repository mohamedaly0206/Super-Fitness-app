sealed class WorkoutsEvent {}

class GetMuscleGroupsEvent extends WorkoutsEvent {
  final String? initialMuscleGroupId;
  GetMuscleGroupsEvent({this.initialMuscleGroupId});
}

class GetMusclesByGroupEvent extends WorkoutsEvent {
  final String muscleGroupId;
  GetMusclesByGroupEvent({required this.muscleGroupId});
}

class SetSelectedGroupEvent extends WorkoutsEvent {
  final String groupId;
  SetSelectedGroupEvent({required this.groupId});
}
