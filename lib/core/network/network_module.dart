import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/modules/exercise/api/api_client/exercise_api_client.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio get dio => DioHelper.dio;

  @singleton
  @Named('MealsDio')
  Dio get mealsDio => DioHelper.mealsDio;

  @singleton
  ExerciseApiClient exerciseApi(Dio dio) => ExerciseApiClient(dio);

  @singleton
  MealsApiClient mealsApi(@Named('MealsDio') Dio dio) => MealsApiClient(dio); 
}