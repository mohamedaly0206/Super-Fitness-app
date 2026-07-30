import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable()
class GetProfileUseCase {
  final ProfileRepo _profileRepo;

  GetProfileUseCase(this._profileRepo);

  Future<UserEntity> call() async {
    return await _profileRepo.getProfile();
  }
}