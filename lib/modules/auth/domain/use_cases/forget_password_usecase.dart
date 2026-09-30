import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepoContract _repository;
  ForgetPasswordUseCase(this._repository);

  Future<BaseResponse<ForgetPasswordEntity>> call({required String email}) {
    return _repository.forgetPassword(email: email);
  }
}
