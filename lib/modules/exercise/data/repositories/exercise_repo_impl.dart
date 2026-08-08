import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/mapper/difficulty_levels_response_mapper.dart';
import 'package:super_fitness_app/core/network/mapper/exercises_response_mapper.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/data/datasources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_levels_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;

  ExerciseRepoImpl({required this.exerciseRemoteDataSource});

  @override
  Future<BaseResponse<List<LevelEntity>>> getLevels() async {
    final response = await exerciseRemoteDataSource.getLevels();

    switch (response) {
      case SuccessBaseResponse<List<LevelEntity>>():
        return SuccessBaseResponse<List<LevelEntity>>(data: response.data);
      case ErrorBaseResponse<List<LevelEntity>>():
        return ErrorBaseResponse<List<LevelEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles() async {
    final response = await exerciseRemoteDataSource.getRandomMuscles();

    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        return SuccessBaseResponse<List<MuscleEntity>>(data: response.data);
      case ErrorBaseResponse<List<MuscleEntity>>():
        return ErrorBaseResponse<List<MuscleEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscles() async {
    final response = await exerciseRemoteDataSource.getAllMuscles();

    switch (response) {
      case SuccessBaseResponse<List<MuscleGroupEntity>>():
        return SuccessBaseResponse<List<MuscleGroupEntity>>(
          data: response.data,
        );
      case ErrorBaseResponse<List<MuscleGroupEntity>>():
        return ErrorBaseResponse<List<MuscleGroupEntity>>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getMusclesByMuscleGroup({
    required String muscleGroupId,
  }) async {
    final response = await exerciseRemoteDataSource.getMusclesByMuscleGroup(
      muscleGroupId: muscleGroupId,
    );

    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        return SuccessBaseResponse<List<MuscleEntity>>(data: response.data);
      case ErrorBaseResponse<List<MuscleEntity>>():
        return ErrorBaseResponse<List<MuscleEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<ExercisesPaginatedResponse>>
  getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) async {
    final response = await exerciseRemoteDataSource
        .getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: primeMoverMuscleId,
          difficultyLevelId: difficultyLevelId,
          page: page,
        );

    switch (response) {
      case SuccessBaseResponse<ExercisesPaginatedResponse>():
        return SuccessBaseResponse<ExercisesPaginatedResponse>(
          data: response.data,
        );
      case ErrorBaseResponse<ExercisesPaginatedResponse>():
        return ErrorBaseResponse<ExercisesPaginatedResponse>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<DifficultyLevelsResponseEntity>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId) async {
    final response = await exerciseRemoteDataSource
        .getDifficultyLevelsByPrimeMover(
          primeMoverMuscleId: primeMoverMuscleId,
        );

    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse<DifficultyLevelsResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse():
        return ErrorBaseResponse<DifficultyLevelsResponseEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<ExercisesResponseEntity>>
  getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    final response = await exerciseRemoteDataSource
        .getExercisesByPrimeMoverAndDifficulty(
          primeMoverMuscleId: primeMoverMuscleId,
          difficultyLevelId: difficultyLevelId,
        );

    switch (response) {
      case SuccessBaseResponse():
        return SuccessBaseResponse<ExercisesResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse():
        return ErrorBaseResponse<ExercisesResponseEntity>(
          failure: response.failure,
        );
    }
  }
}
