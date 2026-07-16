import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';


class RegisterState extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? rePassword;
  final String? gender;
  final num? age;
  final num? weight;
  final num? height;
  final String? goal;
  final String? activityLevel;
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? result;

  const RegisterState({
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
    this.isLoading = false,
    this.errorMessage,
    this.result,
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    num? age,
    num? weight,
    num? height,
    String? goal,
    String? activityLevel,
    bool? isLoading,
    String? errorMessage,
    UserEntity? result,
  }) {
    return RegisterState(
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
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
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
    isLoading,
    errorMessage,
    result,
  ];
}
