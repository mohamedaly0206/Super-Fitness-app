import '../../../../core/network/model/profile_response/profile_response.dart';

import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseDto> getProfile();
  Future<BaseResponse<LogoutEntity>> logout();
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String password,
    required String newPassword,
  });
}
