import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/exercise/api/api_client/exercise_api_client.dart';
import 'package:super_fitness_app/modules/exercise/data/datasources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/core/network/mapper/exercise_mapper.dart';

@LazySingleton(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ExerciseApiClient exerciseApiClient;

  ExerciseRemoteDataSourceImpl({required this.exerciseApiClient});

  @override
  Future<BaseResponse<List<LevelEntity>>> getLevels() async {
    try {
      final response = await exerciseApiClient.getLevels();
      return SuccessBaseResponse<List<LevelEntity>>(
        data: response.levels?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<LevelEntity>>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles() async {
    try {
      final response = await exerciseApiClient.getRandomMuscles();
      return SuccessBaseResponse<List<MuscleEntity>>(
        data: response.muscles?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MuscleEntity>>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscles() async {
    try {
      final response = await exerciseApiClient.getAllMuscles();
      return SuccessBaseResponse<List<MuscleGroupEntity>>(
        data: response.musclesGroup?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MuscleGroupEntity>>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getMusclesByMuscleGroup({
    required String muscleGroupId,
  }) async {
    try {
      final response = await exerciseApiClient.getMusclesByMuscleGroup(
        muscleGroupId: muscleGroupId,
      );
      return SuccessBaseResponse<List<MuscleEntity>>(
        data: response.muscles?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MuscleEntity>>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ExercisesPaginatedResponse>> getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) async {
    try {
      final response = await exerciseApiClient.getExercisesByMuscleAndDifficulty(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
        page: page,
      );
      return SuccessBaseResponse<ExercisesPaginatedResponse>(
        data: ExercisesPaginatedResponse(
          exercises: response.exercises?.map((e) => e.toDomain()).toList() ?? [],
          currentPage: response.currentPage ?? page,
          totalPages: response.totalPages ?? 1,
        ),
      );
    } catch (e) {
      return ErrorBaseResponse<ExercisesPaginatedResponse>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<DifficultyLevelsResponseDto>> getDifficultyLevelsByPrimeMover({
    required String primeMoverMuscleId,
  }) async {
    try {
      final response = await exerciseApiClient.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId,
      );
      return SuccessBaseResponse<DifficultyLevelsResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<DifficultyLevelsResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<ExercisesResponseDto>> getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    try {
      final response = await exerciseApiClient.getExercisesByPrimeMoverAndDifficulty(
        primeMoverMuscleId,
        difficultyLevelId,
      );
      return SuccessBaseResponse<ExercisesResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ExercisesResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
