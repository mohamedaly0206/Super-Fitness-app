import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/change_password_request_dto.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/change_password_response_dto.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/logout_response_dto.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract interface class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET(AuthEndPoint.profileData)
  Future<ProfileResponseDto> getProfile();

  @GET(AuthEndPoint.logout)
  Future<LogoutResponseDto> logout();

  @PATCH(AuthEndPoint.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() ChangePasswordRequestDto request,
  );

  @PUT(AuthEndPoint.editProfile)
  Future<ProfileResponseDto> editProfile(@Body() EditProfileRequest body);

  @MultiPart()
  @PUT(AuthEndPoint.uploadPhoto)
  Future<UploadProfileImageDto> uploadProfilePhoto(
    @Part(name: 'photo') MultipartFile photo,
  );
}
