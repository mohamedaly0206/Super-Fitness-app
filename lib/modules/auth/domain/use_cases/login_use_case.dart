import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_request_body.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

@injectable
class LoginUseCase {
  final AuthRepoContract _authRepo;
  LoginUseCase(this._authRepo);

  Future<BaseResponse<UserEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return _authRepo.login(
      LoginRequestBody(
        email: email,
        password: password,
      ),
    );
  }
}