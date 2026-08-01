import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/profile/data/datasources/profile_remote_data_source.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/upload_profile_image_entity.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  const ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<LogoutEntity>> logout() async {
    final response = await _remoteDataSource.logout();

    switch (response) {
      case SuccessBaseResponse<LogoutEntity>():
        return SuccessBaseResponse<LogoutEntity>(data: response.data);
      case ErrorBaseResponse<LogoutEntity>():
        return ErrorBaseResponse<LogoutEntity>(failure: response.failure);
    }
  }

  @override
  Future<UserEntity> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    return response.user!.toDomain();
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final response = await _remoteDataSource.changePassword(
      password: password,
      newPassword: newPassword,
    );

    switch (response) {
      case SuccessBaseResponse<ChangePasswordEntity>():
        return SuccessBaseResponse<ChangePasswordEntity>(data: response.data);
      case ErrorBaseResponse<ChangePasswordEntity>():
        return ErrorBaseResponse<ChangePasswordEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequest data) async {
    final response = await _remoteDataSource.editProfile(data);
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
    final response = await _remoteDataSource.uploadProfileImage(image);
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
