import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/remote/api_client/auth_api_client.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';

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
}
