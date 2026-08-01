import 'package:super_fitness_app/core/network/model/user_entity.dart';

import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';

abstract class ProfileRepo {
  Future<UserEntity> getProfile();
  Future<BaseResponse<LogoutEntity>> logout();
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String password,
    required String newPassword,
  });
}
