import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable()
class ProfileUseCases {
  final ProfileRepo _profileRepo;

  ProfileUseCases(this._profileRepo);

  Future<UserEntity> getProfile() async {
    return await _profileRepo.getProfile();
  }

  Future<BaseResponse<LogoutEntity>> logout() async {
    return await _profileRepo.logout();
  }
}
