import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_request_body.dart';
import '../../models/request/login_response.dart';

part 'auth_api_client.g.dart';

@RestApi()
@injectable
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(AuthEndPoint.login)
  Future<LoginResponse> login(@Body() LoginRequestBody request);
}