import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';

class WorkoutsState extends Equatable {
  final BaseState<List<MuscleGroupEntity>> muscleGroupsState;
  final BaseState<List<MuscleEntity>> musclesState;
  final String? selectedGroupId;

  const WorkoutsState({
    this.muscleGroupsState = const BaseState<List<MuscleGroupEntity>>(),
    this.musclesState = const BaseState<List<MuscleEntity>>(),
    this.selectedGroupId,
  });

  WorkoutsState copyWith({
    BaseState<List<MuscleGroupEntity>>? muscleGroupsState,
    BaseState<List<MuscleEntity>>? musclesState,
    String? selectedGroupId,
  }) {
    return WorkoutsState(
      muscleGroupsState: muscleGroupsState ?? this.muscleGroupsState,
      musclesState: musclesState ?? this.musclesState,
      selectedGroupId: selectedGroupId ?? this.selectedGroupId,
    );
  }

  @override
  List<Object?> get props => [muscleGroupsState, musclesState, selectedGroupId];
}
