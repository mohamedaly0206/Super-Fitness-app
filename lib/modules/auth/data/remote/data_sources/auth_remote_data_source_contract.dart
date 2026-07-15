import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  );
}
