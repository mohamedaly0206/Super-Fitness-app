import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/login_response.dart';
import 'package:super_fitness_app/modules/auth/data/remote/data_sources/auth_remote_data_source_contract.dart';

import '../../domain/repositories/auth_repo_contract.dart';
import '../models/request/login_request_body.dart';

@Injectable(as: AuthRepoContract)
class AuthRepoImpl implements AuthRepoContract {
  final AuthRemoteDataSourceContract _remoteDataSource;
  const AuthRepoImpl(this._remoteDataSource);

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
