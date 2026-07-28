import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_all_muscles_use_case.dart';
import 'package:super_fitness_app/modules/exercise/domain/use_cases/get_muscles_by_muscle_group_use_case.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_event.dart';

part 'workouts_state.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsState> {
  final GetAllMusclesUseCase getAllMusclesUseCase;
  final GetMusclesByMuscleGroupUseCase getMusclesByMuscleGroupUseCase;

  WorkoutsCubit({
    required this.getAllMusclesUseCase,
    required this.getMusclesByMuscleGroupUseCase,
  }) : super(const WorkoutsState());

  void doEvent(WorkoutsEvent event) {
    switch (event) {
      case GetMuscleGroupsEvent():
        _getMuscleGroups(event.initialMuscleGroupId);
      case GetMusclesByGroupEvent():
        _getMusclesByGroup(event.muscleGroupId);
      case SetSelectedGroupEvent():
        _getMusclesByGroup(event.groupId);
    }
  }

  void _getMuscleGroups(String? initialMuscleGroupId) async {
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
          final groupId = initialMuscleGroupId ?? response.data.first.id;
          _getMusclesByGroup(groupId);
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
        musclesState: state.musclesState.copyWith(isLoadingParam: true),
        selectedGroupId: muscleGroupId,
      ),
    );
    final response = await getMusclesByMuscleGroupUseCase(
      muscleGroupId: muscleGroupId,
    );
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
}
