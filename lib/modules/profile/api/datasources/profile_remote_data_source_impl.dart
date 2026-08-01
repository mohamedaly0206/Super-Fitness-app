import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/network/model/profile_response/profile_response.dart';
import 'package:super_fitness_app/modules/profile/api/api_client/profile_api_client.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/data/models/response/upload_profile_image_dto.dart';
import '../../data/datasources/profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);
  @override
  Future<BaseResponse<ProfileResponseDto>> editProfile(
    EditProfileRequest body,
  ) async {
    try {
      final response = await _profileApiClient.editProfile(body);
      return SuccessBaseResponse(data: response);
    } catch (e) {
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
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
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
    }
  }
}
