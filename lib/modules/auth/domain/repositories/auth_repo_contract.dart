import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';

abstract interface class AuthRepoContract {
  Future<BaseResponse<RegisterResponseEntity>> register(
    RegisterRequestEntity request,
  );
}
