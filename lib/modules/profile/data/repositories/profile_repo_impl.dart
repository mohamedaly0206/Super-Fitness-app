import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/profile/data/datasources/profile_remote_data_source.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _profileRemoteDataSourceImpl;
  const ProfileRepoImpl(this._profileRemoteDataSourceImpl);
  @override
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequest data) async {
    final response = await _profileRemoteDataSourceImpl.editProfile(data);
    switch (response) {
      case SuccessBaseResponse<ProfileResponseDto>():
        return SuccessBaseResponse<UserEntity>(
          data: response.data.user!.toDomain(),
        );
      case ErrorBaseResponse<ProfileResponseDto>():
        return ErrorBaseResponse<UserEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<UploadProfileImageEntity>> uploadProfileImage(
    File image,
  ) async {
    final response = await _profileRemoteDataSourceImpl.uploadProfileImage(
      image,
    );
    switch (response) {
      case SuccessBaseResponse<UploadProfileImageDto>():
        return SuccessBaseResponse<UploadProfileImageEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<UploadProfileImageDto>():
        return ErrorBaseResponse<UploadProfileImageEntity>(
          failure: response.failure,
        );
    }
  }
}
