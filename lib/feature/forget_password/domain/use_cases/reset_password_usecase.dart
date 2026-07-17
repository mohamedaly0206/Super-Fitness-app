import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/reset_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/repository/forget_password_repo_contract.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract _repo;

  ResetPasswordUseCase(this._repo);

  Future<BaseResponse<ResetPasswordEntity>> call({
    required String email,
    required String newPassword,
  }) {
    return _repo.resetPassword(email: email, newPassword: newPassword);
  }
}
