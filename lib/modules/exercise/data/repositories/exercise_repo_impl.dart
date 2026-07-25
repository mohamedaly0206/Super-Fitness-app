import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/mapper/difficulty_levels_response_mapper.dart';
import 'package:super_fitness_app/core/network/mapper/exercises_response_mapper.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_levels_response_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_response_entity.dart';
import '../../domain/repositories/exercise_repo.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import '../datasources/exercise_remote_data_source.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource remoteDataSource;

  const ExerciseRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<DifficultyLevelsResponseEntity>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId) async {
    final response = await remoteDataSource.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId,
    );

    switch (response) {
      case SuccessBaseResponse<DifficultyLevelsResponseDto>():
        return SuccessBaseResponse<DifficultyLevelsResponseEntity>(
          data: response.data.toDomain(),
        );

      case ErrorBaseResponse<DifficultyLevelsResponseDto>():
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
    final response = await remoteDataSource
        .getExercisesByPrimeMoverAndDifficulty(
          primeMoverMuscleId: primeMoverMuscleId,
          difficultyLevelId: difficultyLevelId,
        );

    switch (response) {
      case SuccessBaseResponse<ExercisesResponseDto>():
        return SuccessBaseResponse<ExercisesResponseEntity>(
          data: response.data.toDomain(),
        );

      case ErrorBaseResponse<ExercisesResponseDto>():
        return ErrorBaseResponse<ExercisesResponseEntity>(
          failure: response.failure,
        );
    }
  }
}
