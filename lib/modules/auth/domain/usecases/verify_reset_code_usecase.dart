import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repository.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepository _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<BaseResponse<VerifyResetCodeEntity>> call({
    required String resetCode,
  }) {
    return _repository.verifyResetCode(resetCode: resetCode);
  }
}
