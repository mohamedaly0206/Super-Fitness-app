import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

@injectable
class RegisterUseCase {
  final AuthRepoContract _authRepoContract;

  RegisterUseCase(this._authRepoContract);

  Future<BaseResponse<RegisterResponseEntity>> call(
    RegisterRequestEntity request,
  ) => _authRepoContract.register(request);
}
