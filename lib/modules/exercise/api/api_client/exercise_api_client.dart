import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';

part 'exercise_api_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract interface class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio, {String? baseUrl}) = _ExerciseApiClient;

  @GET(LevelsEndPoint.difficultyByPrimeMover)
  Future<DifficultyLevelsResponseDto> getDifficultyLevelsByPrimeMover(
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
  );

  @GET(ExercisesEndPoint.byMuscleDifficulty)
  Future<ExercisesResponseDto> getExercisesByPrimeMoverAndDifficulty(
    @Query('primeMoverMuscleId') String primeMoverMuscleId,
    @Query('difficultyLevelId') String difficultyLevelId,
  );
}
