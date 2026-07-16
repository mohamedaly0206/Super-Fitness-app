import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';

class RegisterState extends Equatable {
  final BaseState registerState;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? rePassword;
  final Gender? gender;
  final num? age;
  final num? weight;
  final num? height;
  final String? goal;
  final String? activityLevel;

  const RegisterState({
    this.registerState = const BaseState(),
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  RegisterState copyWith({
    BaseState? registerState,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    Gender? gender,
    num? age,
    num? weight,
    num? height,
    String? goal,
    String? activityLevel,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  @override
  List<Object?> get props => [
    registerState,
    firstName,
    lastName,
    email,
    password,
    rePassword,
    gender,
    age,
    weight,
    height,
    goal,
    activityLevel,
  ];
}

enum Gender { male, female }
