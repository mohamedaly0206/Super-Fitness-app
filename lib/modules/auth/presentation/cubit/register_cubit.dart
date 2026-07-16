import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/auth/domain/usecases/register_usecase.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/register_state.dart';


@lazySingleton
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  // ---- Register screen fields ----
  void updateFirstName(String value) =>
      emit(state.copyWith(firstName: value, errorMessage: null));

  void updateLastName(String value) =>
      emit(state.copyWith(lastName: value, errorMessage: null));

  void updateEmail(String value) =>
      emit(state.copyWith(email: value, errorMessage: null));

  /// There is no Confirm Password field in the UI — the backend still
  /// requires `rePassword`, so it's kept in sync with `password`
  /// internally, here, every time it changes.
  void updatePassword(String value) => emit(
    state.copyWith(password: value, rePassword: value, errorMessage: null),
  );

  /// Fills firstName/lastName/email from a successful Google sign-in,
  /// exactly like filling the form manually — no API call, no navigation
  /// to Home. Password/rePassword stay null; the backend register contract
  /// still requires them, so a future developer must decide how a
  /// Google-originated registration supplies a password (out of scope here).
  void fillFromGoogleAccount({String? firstName, String? lastName, String? email}) {
    emit(
      state.copyWith(
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        email: email ?? state.email,
        errorMessage: null,
      ),
    );
  }

  // ---- Remaining Register-screen fields (pre-built for the next developer) ----
  void updateGender(String value) => emit(state.copyWith(gender: value));

  void updateAge(num value) => emit(state.copyWith(age: value));

  void updateWeight(num value) => emit(state.copyWith(weight: value));

  void updateHeight(num value) => emit(state.copyWith(height: value));

  void updateGoal(String value) => emit(state.copyWith(goal: value));

  void updateActivityLevel(String value) =>
      emit(state.copyWith(activityLevel: value));

  /// Calls the real register API with everything accumulated across the
  /// Register screen. Emits a new state with either the successful result
  /// (a [UserEntity]) or an error message. The UI can listen for either
  /// and react accordingly.
  Future<void> submitRegister() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await _registerUseCase(
      firstName: state.firstName ?? '',
      lastName: state.lastName ?? '',
      email: state.email ?? '',
      password: state.password ?? '',
      rePassword: state.rePassword ?? '',
      gender: state.gender,
      age: state.age,
      weight: state.weight,
      height: state.height,
      goal: state.goal,
      activityLevel: state.activityLevel,
    );

    switch (response) {
      case SuccessBaseResponse():
        emit(state.copyWith(isLoading: false, result: response.data));
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: response.failure.message,
          ),
        );
    }
  }
}
