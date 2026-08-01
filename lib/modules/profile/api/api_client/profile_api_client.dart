import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/logout_response_dto.dart';

import '../../../../core/network/model/profile_response/profile_response.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract interface class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET(AuthEndPoint.profileData)
  Future<ProfileResponseDto> getProfile();

  @GET(AuthEndPoint.logout)
  Future<LogoutResponseDto> logout();
}
