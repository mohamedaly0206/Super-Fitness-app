import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

sealed class RegisterIntent {}

class SubmitRegisterIntent extends RegisterIntent {
  final RegisterRequestEntity request;
  SubmitRegisterIntent({required this.request});
}

class SelectGenderIntent extends RegisterIntent {
  final Gender gender;

  SelectGenderIntent(this.gender);
}
