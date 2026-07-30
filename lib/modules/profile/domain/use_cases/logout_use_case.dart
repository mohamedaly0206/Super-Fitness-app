import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/repositories/profile_repo.dart';

@Injectable()
class LogoutUseCase {
  final ProfileRepo _profileRepo;

  LogoutUseCase(this._profileRepo);

  Future<BaseResponse<LogoutEntity>> call() async {
    return await _profileRepo.logout();
  }
}
