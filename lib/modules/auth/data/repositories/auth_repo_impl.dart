import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_response.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repo_contract.dart';

import '../models/request/login_request_body.dart';
import '../models/request/register_request_dto.dart';
import '../models/response/register_response_dto.dart';

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

  @override
  Future<BaseResponse<UserEntity>> login(LoginRequestBody request) async {
    final response = await _remoteDataSource.login(request);

    switch (response) {
      case SuccessBaseResponse<LoginResponse>():
        return SuccessBaseResponse<UserEntity>(
          data: response.data.user?.toDomain() ?? UserEntity(),
        );
      case ErrorBaseResponse<LoginResponse>():
        return ErrorBaseResponse<UserEntity>(failure: response.failure);
    }
  }
}
