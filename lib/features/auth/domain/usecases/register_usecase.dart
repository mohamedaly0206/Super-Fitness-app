import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call({
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
    return _repository.register(
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
    );
  }
}
