import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:super_fitness_app/modules/auth/domain/usecases/forget_password_usecase.dart';
import 'package:super_fitness_app/modules/auth/domain/usecases/reset_password_usecase.dart';
import 'package:super_fitness_app/modules/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'forget_password_event.dart';
import 'forget_password_step.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void doIntent(ForgetPasswordEvent intent) {
    switch (intent) {
      case EmailChangedIntent():
        _onEmailChanged(intent.email);

      case SubmitEmailIntent():
        _submitEmail();

      case OtpChangedIntent():
        _onOtpChanged(intent.otp);

      case VerifyOtpIntent():
        _verifyOtp();

      case ResendOtpIntent():
        _resendOtp();

      case PasswordChangedIntent():
        _onPasswordChanged(intent.password);

      case ConfirmPasswordChangedIntent():
        _onConfirmPasswordChanged(intent.password);

      case SubmitNewPasswordIntent():
        _resetPassword();
    }
  }

  void _onEmailChanged(String value) {
    emit(
      state.copyWith(
        email: value.trim(),
        isEmailButtonEnabled: value.trim().isNotEmpty,
        base: const BaseState(),
      ),
    );
  }

  Future<void> _submitEmail() async {
    emit(state.copyWith(base: const BaseState(isLoading: true)));

    final response = await _forgetPasswordUseCase(email: state.email);

    switch (response) {
      case SuccessBaseResponse<ForgetPasswordEntity>():
        emit(
          state.copyWith(base: const BaseState(), step: ForgetPasswordStep.otp),
        );

        _startTimer();

      case ErrorBaseResponse<ForgetPasswordEntity>():
        emit(
          state.copyWith(
            base: BaseState(errorMessage: response.failure.message),
          ),
        );
    }
  }

  //  OTP

  void _onOtpChanged(String value) {
    emit(
      state.copyWith(
        otp: value,
        hasOtpError: false,
        otpErrorMessage: null,
        isOtpButtonEnabled: value.length == 4,
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (state.otp.length != 4) return;

    emit(state.copyWith(base: const BaseState(isLoading: true)));

    final response = await _verifyResetCodeUseCase(resetCode: state.otp);

    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeEntity>():
        _timer?.cancel();

        emit(
          state.copyWith(
            base: const BaseState(isLoading: false),
            hasOtpError: false,
            otpErrorMessage: null,
            step: ForgetPasswordStep.resetPassword,
          ),
        );

      case ErrorBaseResponse<VerifyResetCodeEntity>():
        emit(
          state.copyWith(
            base: BaseState(isLoading: false, errorMessage: null),
            hasOtpError: true,
            otpErrorMessage: "Invalid verification code",
            isOtpButtonEnabled: false,
          ),
        );
    }
  }

  //  RESET PASSWORD

  void _onPasswordChanged(String value) {
    final enabled = value.length >= 8 && value == state.confirmPassword;

    emit(state.copyWith(password: value, isResetButtonEnabled: enabled));
  }

  void _onConfirmPasswordChanged(String value) {
    final enabled = value.length >= 8 && value == state.password;

    emit(state.copyWith(confirmPassword: value, isResetButtonEnabled: enabled));
  }

  Future<void> _resetPassword() async {
    emit(state.copyWith(base: const BaseState(isLoading: true)));

    final response = await _resetPasswordUseCase(
      email: state.email,
      newPassword: state.password,
    );

    switch (response) {
      case SuccessBaseResponse<ResetPasswordEntity>():
        _timer?.cancel();

        emit(
          state.copyWith(
            base: const BaseState(),
            step: ForgetPasswordStep.success,
            password: '',
            confirmPassword: '',
            email: '',
            otp: '',
            navigateToLogin: true,
          ),
        );

      case ErrorBaseResponse<ResetPasswordEntity>():
        emit(
          state.copyWith(
            base: BaseState(errorMessage: response.failure.message),
          ),
        );
    }
  }

  //  RESEND

  Future<void> _resendOtp() async {
    emit(state.copyWith(isResendEnabled: false, resendSeconds: 30));

    _startTimer();

    await Future.delayed(const Duration(milliseconds: 500));
  }

  //  TIMER

  void _startTimer() {
    _timer?.cancel();

    emit(state.copyWith(resendSeconds: 30, isResendEnabled: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendSeconds <= 1) {
        timer.cancel();

        emit(state.copyWith(resendSeconds: 0, isResendEnabled: true));
      } else {
        emit(state.copyWith(resendSeconds: state.resendSeconds - 1));
      }
    });
  }
}
