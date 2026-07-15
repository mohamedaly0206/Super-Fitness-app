import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super((RegisterState()));

  void handleRegisterIntent(RegisterIntent intent) {
    switch (intent) {
      case SubmitRegisterIntent():
        register(intent.request);
        break;
    }
  }

  Future<void> register(RegisterRequestEntity request) async {
    emit(state.copyWith(registerState: const BaseState(isLoading: true)));
    final response = await _registerUseCase.call(request);
    switch (response) {
      case SuccessBaseResponse<RegisterResponseEntity>():
        emit(state.copyWith(registerState: BaseState(data: response.data)));
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
}
