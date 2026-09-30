import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/edit_profile_request.dart';
import 'package:super_fitness_app/modules/profile/domain/repositories/profile_repo.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepo _profileRepository;

  EditProfileUseCase(this._profileRepository);

  Future<BaseResponse<UserEntity>> call(EditProfileRequest data) async {
    return await _profileRepository.editProfile(data);
  }
}
