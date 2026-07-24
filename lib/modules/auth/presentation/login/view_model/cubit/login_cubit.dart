import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/service/google_auth_service.dart';
import 'package:super_fitness_app/core/service/remote_config_service.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/login_use_case.dart';
import '../intent/login_intent.dart';
import '../state/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GoogleAuthService _googleAuthService;
  final RemoteConfigService _remoteConfigService;

  LoginCubit(
      this._loginUseCase,
      this._googleAuthService,
      this._remoteConfigService,
      ) : super(const LoginState());

  void handleLoginIntent(LoginIntent intent) {
    switch (intent) {
      case SubmitLoginIntent():
        _login(email: intent.email, password: intent.password);
        break;
      case GoogleLoginIntent():
        _loginWithGoogle();
        break;
    }
  }

  Future<void> _loginWithGoogle() async {
    emit(state.copyWith(loginState: const BaseState(isLoading: true)));

    try {
      final googleAccount = await _googleAuthService.signIn();

      if (googleAccount == null) {
        emit(state.copyWith(loginState: const BaseState(isLoading: false)));
        return;
      }

      String googlePassword = '';
      try {
        googlePassword = _remoteConfigService.googlePassword;
        if (googlePassword.isEmpty) {
          googlePassword = 'GoogleAuth@2026';
        }
      } catch (e) {
        googlePassword = 'GoogleAuth@2026';
      }

      final email = googleAccount.email ?? '';

      await _login(email: email, password: googlePassword);
    } catch (e) {
      emit(
        state.copyWith(
          loginState: BaseState(errorMessage: e.toString()),
        ),
      );
    }
  }

  Future<void> _login({required String email, required String password}) async {
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