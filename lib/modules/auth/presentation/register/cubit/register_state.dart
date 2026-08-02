import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

enum RegisterMethod { email, google, facebook }

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
  final bool isEmailRegisterLoading;
  final bool isGoogleRegisterLoading;
  final bool isFacebookRegisterLoading;
  final String? errorMessage;
  final UserEntity? result;

  const RegisterState({
    this.registerState = const BaseState(),
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.age = 20,
    this.weight = 60,
    this.height = 160,
    this.goal,
    this.activityLevel,
    this.isEmailRegisterLoading = false,
    this.isGoogleRegisterLoading = false,
    this.isFacebookRegisterLoading = false,
    this.errorMessage,
    this.result,
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
    bool? isEmailRegisterLoading,
    bool? isGoogleRegisterLoading,
    bool? isFacebookRegisterLoading,
    String? errorMessage,
    UserEntity? result,
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
      isEmailRegisterLoading:
          isEmailRegisterLoading ?? this.isEmailRegisterLoading,
      isGoogleRegisterLoading:
          isGoogleRegisterLoading ?? this.isGoogleRegisterLoading,
      isFacebookRegisterLoading:
          isFacebookRegisterLoading ?? this.isFacebookRegisterLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      result: result ?? this.result,
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
    isEmailRegisterLoading,
    isGoogleRegisterLoading,
    isFacebookRegisterLoading,
    errorMessage,
    result,
  ];
}

enum Gender { male, female }
