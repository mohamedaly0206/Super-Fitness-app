import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/network/mapper/change_password_response_mapper.dart';
import 'package:super_fitness_app/core/network/mapper/logout_response_mapper.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/change_password_request_dto.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../api_client/profile_api_client.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<ProfileResponseDto> getProfile() async {
    return await _profileApiClient.getProfile();
  }

  @override
  Future<BaseResponse<LogoutEntity>> logout() async {
    try {
      final response = await _profileApiClient.logout();
      return SuccessBaseResponse<LogoutEntity>(data: response.toDomain());
    } catch (e) {
      return ErrorBaseResponse<LogoutEntity>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String password,
    required String newPassword,
  }) async {
    try {
      final response = await _profileApiClient.changePassword(
        ChangePasswordRequestDto(password: password, newPassword: newPassword),
      );
      return SuccessBaseResponse<ChangePasswordEntity>(
        data: response.toDomain(),
      );
    } catch (e) {
      return ErrorBaseResponse<ChangePasswordEntity>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<ProfileResponseDto>> editProfile(
    EditProfileRequest body,
  ) async {
    try {
      final response = await _profileApiClient.editProfile(body);
      return SuccessBaseResponse(data: response);
    } catch (e) {
      return ErrorBaseResponse(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<UploadProfileImageDto>> uploadProfileImage(
    File image,
  ) async {
    try {
      final multipart = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
      final response = await _profileApiClient.uploadProfilePhoto(multipart);
      return SuccessBaseResponse(data: response);
    } catch (e) {
      return ErrorBaseResponse(failure: ErrorHandler.handle(e));
    }
  }
}
