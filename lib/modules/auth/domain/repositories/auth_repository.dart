import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    String? gender,
    num? height,
    num? weight,
    num? age,
    String? goal,
    String? activityLevel,
  });
}
