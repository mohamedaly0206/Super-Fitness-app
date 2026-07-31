import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/repositories/profile_repo.dart';

@Injectable()
class ChangePasswordUseCase {
  final ProfileRepo _profileRepo;

  ChangePasswordUseCase(this._profileRepo);

  Future<BaseResponse<ChangePasswordEntity>> call({
    required String password,
    required String newPassword,
  }) async {
    return await _profileRepo.changePassword(
      password: password,
      newPassword: newPassword,
    );
  }
}
