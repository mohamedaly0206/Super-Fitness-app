import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/data_source/forget_password_datasource_contract.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/feature/forget_password/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/change_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/forget_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/reset_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/repository/forget_password_repo_contract.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  final ForgetPasswordDataSourceContract _dataSource;

  ForgetPasswordRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _dataSource.changePassword(
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
    final response = await _dataSource.forgotPassword(
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
    final response = await _dataSource.resetPassword(
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
    final response = await _dataSource.verifyResetCode(
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
