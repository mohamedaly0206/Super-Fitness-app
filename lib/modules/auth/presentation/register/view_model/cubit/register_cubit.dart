import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/core/service/google_auth_service.dart';
import 'package:super_fitness_app/core/service/remote_config_service.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/response/register_response_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/use_cases/register_use_case.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final GoogleAuthService _googleAuthService;
  final RemoteConfigService _remoteConfigService;

  RegisterCubit(
      this._registerUseCase,
      this._googleAuthService,
      this._remoteConfigService,
      ) : super(RegisterState());

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
        break;
      case SelectWeightIntent():
        _changeWeight(intent.weight);
        break;
      case SelectHeightIntent():
        _changeHeight(intent.height);
        break;
      case SelectGoalIntent():
        _changeGoal(intent.goal);
        break;
      case SelectActivityLevelIntent():
        _changeActivityLevel(intent.activityLevel);
        break;
      case GoogleRegisterIntent():
        _registerWithGoogle();
        break;
      case FacebookRegisterIntent():
        _registerWithFacebook();
        break;
    }
  }

  Future<void> _registerWithGoogle() async {
    emit(state.copyWith(registerState: const BaseState(isLoading: true)));

    try {
      final googleAccount = await _googleAuthService.signIn();

      if (googleAccount == null) {
        emit(state.copyWith(registerState: const BaseState(isLoading: false)));
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

      // 🔹 استخراج البيانات بشكل يحمي الكود من الاختلاف في الموديل
      final String displayName = (googleAccount as dynamic).displayName ??
          (googleAccount as dynamic).user?.displayName ?? '';
      final String email = (googleAccount as dynamic).email ??
          (googleAccount as dynamic).user?.email ?? '';

      final nameParts = displayName.trim().split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts.first : 'User';
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User';

      fillFromGoogleAccount(
        firstName: firstName,
        lastName: lastName,
        email: email,
        googlePassword: googlePassword,
      );

      emit(state.copyWith(registerState: const BaseState(isLoading: false)));
    } catch (e) {
      emit(
        state.copyWith(
          registerState: BaseState(errorMessage: e.toString()),
        ),
      );
    }
  }

  Future<void> _registerWithFacebook() async {
    emit(state.copyWith(registerState: const BaseState(isLoading: true)));

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        final email = userData['email'] as String? ?? '';
        final name = userData['name'] as String? ?? '';

        if (email.isEmpty) {
          emit(
            state.copyWith(
              registerState: const BaseState(
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

        final nameParts = name.trim().split(' ');
        final firstName = nameParts.isNotEmpty ? nameParts.first : 'User';
        final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User';

        fillFromGoogleAccount(
          firstName: firstName,
          lastName: lastName,
          email: email,
          googlePassword: facebookPassword,
        );

        emit(state.copyWith(registerState: const BaseState(isLoading: false)));
      } else {
        emit(state.copyWith(registerState: const BaseState(isLoading: false)));
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerState: BaseState(errorMessage: e.toString()),
        ),
      );
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

  void updateFirstName(String value) =>
      emit(state.copyWith(firstName: value, errorMessage: null));

  void updateLastName(String value) =>
      emit(state.copyWith(lastName: value, errorMessage: null));

  void updateEmail(String value) =>
      emit(state.copyWith(email: value, errorMessage: null));

  void updatePassword(String value) => emit(
    state.copyWith(password: value, rePassword: value, errorMessage: null),
  );

  void fillFromGoogleAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String googlePassword,
  }) {
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: googlePassword,
        rePassword: googlePassword,
        errorMessage: null,
      ),
    );
  }
}