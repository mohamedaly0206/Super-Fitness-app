import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/change_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/forget_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/change_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/forget_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/verify_reset_code_response.dart';

abstract interface class ForgetPasswordDataSourceContract {
  Future<BaseResponse<ForgetPasswordResponseDto>> forgotPassword(
    ForgetPasswordRequestDto request,
  );

  Future<BaseResponse<VerifyResetCodeResponseDto>> verifyResetCode(
    VerifyResetCodeRequestDto request,
  );

  Future<BaseResponse<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto request,
  );

  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequestDto request,
  );
}
