import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/data/models/response/register_response_dto.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImpl implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;
  const AuthRepoImpl(this._remoteDataSource);
  @override
  Future<BaseResponse<RegisterResponseEntity>> register(
    RegisterRequestEntity request,
  ) async {
    final response = await _remoteDataSource.register(
      RegisterRequestDto.fromDomain(request),
    );
    switch (response) {
      case SuccessBaseResponse<RegisterResponseDto>():
        return SuccessBaseResponse<RegisterResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<RegisterResponseDto>():
        return ErrorBaseResponse<RegisterResponseEntity>(
          failure: response.failure,
        );
    }
  }
}
