import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'exercise_api_client.g.dart';

@RestApi()
abstract interface class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio, {String baseUrl}) = _ExerciseApiClient;
}
