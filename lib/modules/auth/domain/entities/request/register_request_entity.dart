import 'package:equatable/equatable.dart';

class RegisterRequestEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String? gender;
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
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
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
