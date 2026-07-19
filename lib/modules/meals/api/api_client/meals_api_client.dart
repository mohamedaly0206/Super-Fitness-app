import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'meals_api_client.g.dart';

@RestApi()
abstract interface class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(@Named('MealsDio') Dio dio, {String baseUrl}) =
      _MealsApiClient;
}
