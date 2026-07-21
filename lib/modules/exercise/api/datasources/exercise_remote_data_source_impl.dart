import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/exercise/api/api_client/exercise_api_client.dart';
import 'package:super_fitness_app/modules/exercise/data/datasources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';

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
          exercises: response.exercises?.map((e) => e.toEntity()).toList() ?? [],
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
}
