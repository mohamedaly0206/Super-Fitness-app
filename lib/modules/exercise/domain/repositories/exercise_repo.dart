import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_levels_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';

abstract class ExerciseRepo {
  Future<BaseResponse<List<LevelEntity>>> getLevels();
  Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles();
  Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscles();
  Future<BaseResponse<List<MuscleEntity>>> getMusclesByMuscleGroup({
    required String muscleGroupId,
  });
  Future<BaseResponse<ExercisesPaginatedResponse>>
  getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  });
  Future<BaseResponse<DifficultyLevelsResponseEntity>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId);
  Future<BaseResponse<ExercisesResponseEntity>>
  getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
