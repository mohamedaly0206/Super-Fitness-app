import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

class RegisterRequestEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final Gender? gender;
  final num? height;
  final num? weight;
  final num? age;
  final String? goal;
  final String? activityLevel;

  const RegisterRequestEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    required this.goal,
    required this.activityLevel,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    password,
    rePassword,
    gender,
    height,
    weight,
    age,
    goal,
    activityLevel,
  ];
}
