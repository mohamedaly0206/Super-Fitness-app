import 'dart:io';

import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';

abstract interface class ProfileRemoteDataSource {
  Future<BaseResponse<ProfileResponseDto>> editProfile(EditProfileRequest body);

  Future<BaseResponse<UploadProfileImageDto>> uploadProfileImage(File image);
}
