import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/network/endpoints.dart';
import '../../../../core/network/model/profile_response/profile_response.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract interface class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET(AuthEndPoint.profileData)
  Future<ProfileResponseDto> getProfile();

}
