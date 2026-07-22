import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/network/safe_api_caller.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness_app/modules/auth/data/remote/api_client/auth_api_client.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';

import '../../models/request/login_request_body.dart';
import '../../models/request/login_response.dart';

const String _mockVerifyResetCode = "1234";

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient _authApiClient;
  final SafeApiCaller _safeApiCaller;
  const AuthRemoteDataSourceImpl(this._authApiClient, this._safeApiCaller);
  @override
  Future<BaseResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async {
    try {
      final response = await _authApiClient.register(request);

      return SuccessBaseResponse<RegisterResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<RegisterResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequestBody request) async {
    try {
      final response = await _authApiClient.login(request);

      return SuccessBaseResponse<LoginResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<LoginResponse>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequestDto request,
  ) {
    return _safeApiCaller.safeCall(() async {
      final dto = await _authApiClient.changePassword(request);
      return dto;
    });
  }

  @override
  Future<BaseResponse<ForgetPasswordResponseDto>> forgotPassword(
    ForgetPasswordRequestDto request,
  ) {
    return _safeApiCaller.safeCall(() async {
      await Future.delayed(const Duration(seconds: 2));

      return ForgetPasswordResponseDto(
        message: "Verification code sent successfully",
      );
    });
  }

  @override
  Future<BaseResponse<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto request,
  ) {
    return _safeApiCaller.safeCall(() async {
      await Future.delayed(const Duration(seconds: 2));

      return ResetPasswordResponseDto(message: "Password reset successfully");
    });
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponseDto>> verifyResetCode(
    VerifyResetCodeRequestDto request,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    if (request.resetCode == _mockVerifyResetCode) {
      return SuccessBaseResponse(
        data: VerifyResetCodeResponseDto(status: "Success"),
      );
    }

    return ErrorBaseResponse(
      failure: Failure(message: "Invalid verification code"),
    );
  }
}
