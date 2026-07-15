import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/api/api_client/auth_api_client.dart';
import 'package:super_fitness_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:super_fitness_app/features/auth/data/models/register_request_dto.dart';
import 'package:super_fitness_app/features/auth/data/models/register_response_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<RegisterResponseDto> register(RegisterRequestDto request) {
    return _apiClient.register(request);
  }
}
