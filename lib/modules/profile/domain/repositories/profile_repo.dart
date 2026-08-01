import 'dart:io';

import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';

abstract interface class ProfileRepo {
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequest data);

  Future<BaseResponse<UploadProfileImageEntity>> uploadProfileImage(File image);
}
