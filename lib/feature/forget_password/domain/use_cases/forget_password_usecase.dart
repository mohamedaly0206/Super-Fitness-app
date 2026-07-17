import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/feature/forget_password/domain/entity/forget_password_entity.dart';
import 'package:super_fitness_app/feature/forget_password/domain/repository/forget_password_repo_contract.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepoContract _repo;

  ForgetPasswordUseCase(this._repo);

  Future<BaseResponse<ForgetPasswordEntity>> call({required String email}) {
    return _repo.forgetPassword(email: email);
  }
}
