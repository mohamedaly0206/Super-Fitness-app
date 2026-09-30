import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/meals/data/models/meal_categories_response_dto.dart';
import 'package:super_fitness_app/modules/meals/data/models/meal_details_response_dto.dart';
import 'package:super_fitness_app/modules/meals/data/models/meals_response_dto.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';

part 'meals_api_client.g.dart';

@RestApi()
abstract interface class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(@Named('MealsDio') Dio dio, {String baseUrl}) =
      _MealsApiClient;

  @GET(MealEndPoint.categories)
  Future<MealCategoriesResponseDto> getCategories();

  @GET(MealEndPoint.filter)
  Future<MealsResponseDto> getMealsByCategory({
    @Query("c") required String category,
  });

  @GET(MealEndPoint.lookup)
  Future<MealDetailsResponseDto> getMealDetails({
    @Query("i") required String id,
  });
  @GET(MealEndPoint.lookup)
  Future<MealsDetailsDto> getMeals(@Query('i') String id);
}
