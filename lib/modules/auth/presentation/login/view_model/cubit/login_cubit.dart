import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/login_use_case.dart';
import '../intent/login_intent.dart';
import '../state/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState());

  void handleLoginIntent(LoginIntent intent) {
    switch (intent) {
      case SubmitLoginIntent():
        _login(
          email: intent.email,
          password: intent.password,
        );
        break;
    }
  }

  Future<void> _login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(loginState: const BaseState(isLoading: true)));

    final response = await _loginUseCase.call(
      email: email,
      password: password,
      rememberMe: false,
    );

    switch (response) {
      case SuccessBaseResponse<UserEntity>():
        emit(state.copyWith(loginState: BaseState(data: response.data)));
        break;
      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            loginState: BaseState(errorMessage: response.failure.message),
          ),
        );
        break;
    }
  }
}