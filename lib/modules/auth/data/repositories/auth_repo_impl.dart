import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

import '../models/request/login_request_body.dart';
import '../models/request/register_request_dto.dart';
import '../models/request/verify_reset_code_request.dart';
import '../models/response/register_response_dto.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImpl implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;
  const AuthRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<RegisterResponseEntity>> register(
    RegisterRequestEntity request,
  ) async {
    final response = await _remoteDataSource.register(
      RegisterRequestDto.fromDomain(request),
    );
    switch (response) {
      case SuccessBaseResponse<RegisterResponseDto>():
        return SuccessBaseResponse<RegisterResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<RegisterResponseDto>():
        return ErrorBaseResponse<RegisterResponseEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<UserEntity>> login(LoginRequestBody request) async {
    final response = await _remoteDataSource.login(request);

    switch (response) {
      case SuccessBaseResponse<LoginResponse>():
        return SuccessBaseResponse<UserEntity>(
          data: response.data.user?.toDomain() ?? UserEntity(),
        );
      case ErrorBaseResponse<LoginResponse>():
        return ErrorBaseResponse<UserEntity>(failure: response.failure);
    }
  }


  
  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _remoteDataSource.changePassword(
      ChangePasswordRequestDto(
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    );

    switch (response) {
      case SuccessBaseResponse<ChangePasswordResponseDto>():
        return SuccessBaseResponse<ChangePasswordEntity>(
          data: response.data.toEntity(),
        );

      case ErrorBaseResponse<ChangePasswordResponseDto>():
        return ErrorBaseResponse<ChangePasswordEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  }) async {
    final response = await _remoteDataSource.forgetPassword(
      ForgetPasswordRequestDto(email: email),
    );

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordResponseDto>():
        return SuccessBaseResponse<ForgetPasswordEntity>(
          data: response.data.toEntity(),
        );

      case ErrorBaseResponse<ForgetPasswordResponseDto>():
        return ErrorBaseResponse<ForgetPasswordEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await _remoteDataSource.resetPassword(
      ResetPasswordRequestDto(email: email, newPassword: newPassword),
    );

    switch (response) {
      case SuccessBaseResponse<ResetPasswordResponseDto>():
        return SuccessBaseResponse<ResetPasswordEntity>(
          data: response.data.toEntity(),
        );

      case ErrorBaseResponse<ResetPasswordResponseDto>():
        return ErrorBaseResponse<ResetPasswordEntity>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    final response = await _remoteDataSource.verifyResetCode(
      VerifyResetCodeRequestDto(resetCode: resetCode),
    );

    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeResponseDto>():
        return SuccessBaseResponse<VerifyResetCodeEntity>(
          data: response.data.toEntity(),
        );

      case ErrorBaseResponse<VerifyResetCodeResponseDto>():
        return ErrorBaseResponse<VerifyResetCodeEntity>(
          failure: response.failure,
        );
    }
  }
  
}
