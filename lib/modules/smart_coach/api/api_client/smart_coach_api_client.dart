import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'smart_coach_api_client.g.dart';

@RestApi()
abstract interface class SmartCoachApiClient {
  @factoryMethod
  factory SmartCoachApiClient(Dio dio, {String baseUrl}) = _SmartCoachApiClient;
}
