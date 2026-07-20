import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/exercise/data/models/exercises_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/data/models/muscles_response_dto.dart';

part 'exercise_api_client.g.dart';

@RestApi()
abstract interface class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio, {String baseUrl}) = _ExerciseApiClient;

  @GET(Endpoints.levels)
  Future<LevelsResponseDto> getLevels();

  @GET(MusclesEndPoint.random)
  Future<MusclesResponseDto> getRandomMuscles();

  @GET(ExercisesEndPoint.byMuscleDifficulty)
  Future<ExercisesResponseDto> getExercisesByMuscleAndDifficulty({
    @Query("primeMoverMuscleId") required String primeMoverMuscleId,
    @Query("difficultyLevelId") required String difficultyLevelId,
  });
}
