import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<BaseResponse<DifficultyLevelsResponseDto>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId);

  Future<BaseResponse<ExercisesResponseDto>>
  getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
