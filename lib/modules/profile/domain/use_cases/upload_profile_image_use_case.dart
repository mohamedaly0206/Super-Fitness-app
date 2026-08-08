import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/repositories/profile_repo.dart';

@injectable
class UploadProfileImageUseCase {
  final ProfileRepo _profileRepo;
  UploadProfileImageUseCase(this._profileRepo);
  Future<BaseResponse<UploadProfileImageEntity>> call(File image) async {
    return await _profileRepo.uploadProfileImage(image);
  }
}
