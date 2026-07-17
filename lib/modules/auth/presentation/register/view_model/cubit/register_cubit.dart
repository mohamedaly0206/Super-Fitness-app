import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super((RegisterState()));

  void handleRegisterIntent(RegisterIntent intent) {
    switch (intent) {
      case SubmitRegisterIntent():
        _register(intent.request);
        break;
      case SelectGenderIntent():
        _changeGender(intent.gender);
        break;
      case SelectAgeIntent():
        _changeAge(intent.age);
      case SelectWeightIntent():
        _changeWeight(intent.weight);
      case SelectHeightIntent():
        _changeHeight(intent.height);
      case SelectGoalIntent():
        _changeGoal(intent.goal);
      case SelectActivityLevelIntent():
        _changeActivityLevel(intent.activityLevel);
    }
  }

  Future<void> _register(RegisterRequestEntity request) async {
    emit(state.copyWith(registerState: const BaseState(isLoading: true)));
    final response = await _registerUseCase.call(request);
    switch (response) {
      case SuccessBaseResponse<RegisterResponseEntity>():
        emit(state.copyWith(registerState: BaseState(data: response.data)));
        emit(
          state.copyWith(
            firstName: null,
            lastName: null,
            email: null,
            password: null,
            rePassword: null,
            gender: null,
            age: null,
            weight: null,
            height: null,
            goal: null,
            activityLevel: null,
          ),
        );

        break;
      case ErrorBaseResponse<RegisterResponseEntity>():
        emit(
          state.copyWith(
            registerState: BaseState(errorMessage: response.failure.message),
          ),
        );
        break;
    }
  }

  void _changeGender(Gender gender) {
    emit(state.copyWith(gender: gender));
    log(state.gender.toString());
  }

  void _changeAge(num age) {
    emit(state.copyWith(age: age));
    log(state.age.toString());
  }

  void _changeWeight(num weight) {
    emit(state.copyWith(weight: weight));
    log(state.weight.toString());
  }

  void _changeHeight(num height) {
    emit(state.copyWith(height: height));
    log(state.height.toString());
  }

  void _changeGoal(String goal) {
    emit(state.copyWith(goal: goal));
    log(state.goal.toString());
  }

  void _changeActivityLevel(String activityLevel) {
    emit(state.copyWith(activityLevel: activityLevel));
    log(state.activityLevel.toString());
  }
}
