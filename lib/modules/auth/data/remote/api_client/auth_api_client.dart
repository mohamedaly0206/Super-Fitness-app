import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';

part 'auth_api_client.g.dart';

@RestApi()
@injectable
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AuthEndPoint.register)
  Future<RegisterResponseDto> register(@Body() RegisterRequestDto request);
}
