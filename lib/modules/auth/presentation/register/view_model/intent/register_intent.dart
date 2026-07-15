import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';

sealed class RegisterIntent {}

class SubmitRegisterIntent extends RegisterIntent {
  final RegisterRequestEntity request;
  SubmitRegisterIntent({required this.request});
}
