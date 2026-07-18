import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/network/safe_api_caller.dart';
import 'package:super_fitness_app/modules/auth/data/remote/datasources/auth_remote_data_source.dart';
import 'package:super_fitness_app/modules/auth/data/models/request/register_request_dto.dart';
import 'package:super_fitness_app/modules/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDatasource;
  final SafeApiCaller _safeApiCaller;

  AuthRepositoryImpl(this._remoteDatasource, this._safeApiCaller);

  @override
  Future<BaseResponse<UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    String? gender,
    num? height,
    num? weight,
    num? age,
    String? goal,
    String? activityLevel,
  }) {
    return _safeApiCaller.safeCall(() async {
      final response = await _remoteDatasource.register(
        RegisterRequestDto(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          gender: gender,
          height: height,
          weight: weight,
          age: age,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );

      return (response.user ?? UserDto()).toDomain();
    });
  }
}
