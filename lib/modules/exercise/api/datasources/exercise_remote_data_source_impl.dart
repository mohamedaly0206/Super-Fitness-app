import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/safe_api_caller.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';
import '../../data/datasources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import '../api_client/exercise_api_client.dart';

@LazySingleton(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ExerciseApiClient _apiClient;
  final SafeApiCaller _safeApiCaller;

  const ExerciseRemoteDataSourceImpl(this._apiClient, this._safeApiCaller);

  @override
  Future<BaseResponse<DifficultyLevelsResponseDto>>
  getDifficultyLevelsByPrimeMover(String primeMoverMuscleId) {
    return _safeApiCaller.safeCall(
      () => _apiClient.getDifficultyLevelsByPrimeMover(primeMoverMuscleId),
    );
  }

  @override
  Future<BaseResponse<ExercisesResponseDto>>
  getExercisesByPrimeMoverAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _safeApiCaller.safeCall(
      () => _apiClient.getExercisesByPrimeMoverAndDifficulty(
        primeMoverMuscleId,
        difficultyLevelId,
      ),
    );
  }
}
