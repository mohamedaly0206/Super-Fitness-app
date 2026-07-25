import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_levels_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_response_entity.dart';

abstract class ExerciseRepo {
  Future<BaseResponse<DifficultyLevelsResponseEntity>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId);

  Future<BaseResponse<ExercisesResponseEntity>>
  getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
