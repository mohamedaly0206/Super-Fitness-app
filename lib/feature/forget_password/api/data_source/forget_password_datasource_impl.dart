import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/network/safe_api_caller.dart';
import 'package:super_fitness_app/feature/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:super_fitness_app/feature/forget_password/data/data_source/forget_password_datasource_contract.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/verify_reset_code_response.dart';

const String _mockVerifyResetCode = "1234";

@Injectable(as: ForgetPasswordDataSourceContract)
class ForgetPasswordDatasourceImpl implements ForgetPasswordDataSourceContract {
  final ForgetPasswordApiClient _apiClient;
  final SafeApiCaller _safeApiCaller;

  ForgetPasswordDatasourceImpl(this._apiClient, this._safeApiCaller);

  @override
  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequestDto request,
  ) {
    return _safeApiCaller.safeCall(() async {
      final dto = await _apiClient.changePassword(request);
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
