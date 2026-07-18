import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/forget_password_repo_contract.dart';

@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract _repo;

  VerifyResetCodeUseCase(this._repo);

  Future<BaseResponse<VerifyResetCodeEntity>> call({
    required String resetCode,
  }) {
    return _repo.verifyResetCode(resetCode: resetCode);
  }
}
