import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/forget_password_repo_contract.dart';

@injectable
class ChangePasswordUseCase {
  final ForgetPasswordRepoContract _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<ChangePasswordEntity>> call({
    required String oldPassword,
    required String newPassword,
  }) {
    return _repo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
