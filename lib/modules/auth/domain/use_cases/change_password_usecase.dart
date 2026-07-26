import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepoContract _repository;

  ChangePasswordUseCase(this._repository);

  Future<BaseResponse<ChangePasswordEntity>> call({
    required String oldPassword,
    required String newPassword,
  }) {
    return _repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
