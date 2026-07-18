import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/forget_password_repo_contract.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepoContract _repo;

  ForgetPasswordUseCase(this._repo);

  Future<BaseResponse<ForgetPasswordEntity>> call({required String email}) {
    return _repo.forgetPassword(email: email);
  }
}
