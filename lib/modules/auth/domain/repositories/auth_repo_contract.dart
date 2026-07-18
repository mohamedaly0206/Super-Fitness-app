import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_request_body.dart';

abstract interface class AuthRepoContract {
  Future<BaseResponse<UserEntity>> login(
      LoginRequestBody request,
      );
}