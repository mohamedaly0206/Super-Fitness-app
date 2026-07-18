import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';

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
