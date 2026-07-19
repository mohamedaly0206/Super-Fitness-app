import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/remote/api_client/auth_api_client.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';

import '../../models/request/login_request_body.dart';
import '../../models/request/login_response.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient _authApiClient;
  const AuthRemoteDataSourceImpl(this._authApiClient);
  @override
  Future<BaseResponse<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async {
    try {
      final response = await _authApiClient.register(request);

      return SuccessBaseResponse<RegisterResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<RegisterResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequestBody request) async {
    try {
      final response = await _authApiClient.login(request);

      return SuccessBaseResponse<LoginResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<LoginResponse>(failure: ErrorHandler.handle(e));
    }
  }
}
