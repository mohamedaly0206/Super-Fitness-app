import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_response.dart';

import '../../models/request/login_request_body.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  );
  Future<BaseResponse<LoginResponse>> login(LoginRequestBody request);
}
