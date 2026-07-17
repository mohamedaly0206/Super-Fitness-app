import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/change_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/forget_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/reset_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/verify_reset_code_entity.dart';

abstract interface class ForgetPasswordRepoContract {
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  });

  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode({
    required String resetCode,
  });

  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  });

  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
