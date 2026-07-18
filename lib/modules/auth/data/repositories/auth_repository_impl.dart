import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/network/safe_api_caller.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness_app/modules/auth/data/remote/datasources/auth_remote_data_source.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDatasource;
  final SafeApiCaller _safeApiCaller;

  AuthRepositoryImpl(this._remoteDatasource, this._safeApiCaller);

  @override
  Future<BaseResponse<UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    String? gender,
    num? height,
    num? weight,
    num? age,
    String? goal,
    String? activityLevel,
  }) {
    return _safeApiCaller.safeCall(() async {
      final response = await _remoteDatasource.register(
        RegisterRequestDto(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          gender: gender,
          height: height,
          weight: weight,
          age: age,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );

      return (response.user ?? UserDto()).toDomain();
    });
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _remoteDatasource.changePassword(
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
    final response = await _remoteDatasource.forgotPassword(
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
    final response = await _remoteDatasource.resetPassword(
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
    final response = await _remoteDatasource.verifyResetCode(
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
