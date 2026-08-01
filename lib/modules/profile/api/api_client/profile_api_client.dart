import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract interface class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @PUT(AuthEndPoint.editProfile)
  Future<ProfileResponseDto> editProfile(@Body() EditProfileRequest body);

  @MultiPart()
  @PUT(AuthEndPoint.uploadPhoto)
  Future<UploadProfileImageDto> uploadProfilePhoto(
    @Part(name: 'photo') MultipartFile photo,
  );
}
