import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/service/google_auth_service.dart';
import 'package:super_fitness_app/core/service/remote_config_service.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'login_event.dart';
import 'login_state.dart';

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

  void doEvent(LoginEvent event) {
    switch (event) {
      case SubmitLoginEvent():
        _login(email: event.email, password: event.password);
        break;
      case GoogleLoginEvent():
        _loginWithGoogle();
        break;
      case FacebookLoginEvent():
        _loginWithFacebook();
        break;
    }
  }

  Future<void> _loginWithGoogle() async {
    emit(state.copyWith(isGoogleLoginLoading: true));

    try {
      final googleAccount = await _googleAuthService.signIn();

      if (googleAccount == null) {
        emit(state.copyWith(isGoogleLoginLoading: false));
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

      await _login(
        email: email,
        password: googlePassword,
        method: LoginMethod.google,
      );
    } catch (e) {
      emit(
        state.copyWith(
          isGoogleLoginLoading: false,
          loginState: BaseState(errorMessage: e.toString()),
        ),
      );
    }
  }

  Future<void> _loginWithFacebook() async {
    emit(state.copyWith(isFacebookLoginLoading: true));

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        final email = userData['email'] as String? ?? '';

        if (email.isEmpty) {
          emit(
            state.copyWith(
              isFacebookLoginLoading: false,
              loginState: const BaseState(
                errorMessage: 'Facebook account does not provide an email address.',
              ),
            ),
          );
          return;
        }

        String facebookPassword = '';
        try {
          facebookPassword = _remoteConfigService.facebookPassword;
          if (facebookPassword.isEmpty) {
            facebookPassword = 'FacebookAuth@2026';
          }
        } catch (e) {
          facebookPassword = 'FacebookAuth@2026';
        }

        await _login(
          email: email,
          password: facebookPassword,
          method: LoginMethod.facebook,
        );
      } else {
        emit(state.copyWith(isFacebookLoginLoading: false));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isFacebookLoginLoading: false,
          loginState: BaseState(errorMessage: e.toString()),
        ),
      );
    }
  }

  Future<void> _login({
    required String email,
    required String password,
    LoginMethod method = LoginMethod.email,
  }) async {
    _setLoading(method, true);

    final response = await _loginUseCase.call(
      email: email,
      password: password,
      rememberMe: false,
    );

    switch (response) {
      case SuccessBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            loginState: BaseState(data: response.data),
            isEmailLoginLoading: false,
            isGoogleLoginLoading: false,
            isFacebookLoginLoading: false,
          ),
        );
        break;
      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            loginState: BaseState(errorMessage: response.failure.message),
            isEmailLoginLoading: false,
            isGoogleLoginLoading: false,
            isFacebookLoginLoading: false,
          ),
        );
        break;
    }
  }

  void _setLoading(LoginMethod method, bool value) {
    switch (method) {
      case LoginMethod.email:
        emit(state.copyWith(isEmailLoginLoading: value));
        break;
      case LoginMethod.google:
        emit(state.copyWith(isGoogleLoginLoading: value));
        break;
      case LoginMethod.facebook:
        emit(state.copyWith(isFacebookLoginLoading: value));
        break;
    }
  }
}
