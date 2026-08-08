import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_state.dart';
import 'forget_password_step.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<dynamic> base;
  final String? otpErrorMessage;
  final ForgetPasswordStep step;
  final String email;
  final String otp;
  final String password;
  final String confirmPassword;
  final bool isEmailButtonEnabled;
  final bool isOtpButtonEnabled;
  final bool isResetButtonEnabled;
  final bool isResendEnabled;
  final int resendSeconds;
  final bool hasOtpError;
  final bool navigateToLogin;

  const ForgetPasswordState({
    this.base = const BaseState(),
    this.step = ForgetPasswordStep.email,
    this.otpErrorMessage,
    this.email = '',
    this.otp = '',
    this.password = '',
    this.confirmPassword = '',
    this.isEmailButtonEnabled = false,
    this.isOtpButtonEnabled = false,
    this.isResetButtonEnabled = false,
    this.isResendEnabled = false,
    this.resendSeconds = 30,
    this.hasOtpError = false,
    this.navigateToLogin = false,
  });

  ForgetPasswordState copyWith({
    BaseState<dynamic>? base,
    ForgetPasswordStep? step,
    String? otpErrorMessage,
    String? email,
    String? otp,
    String? password,
    String? confirmPassword,
    bool? isEmailButtonEnabled,
    bool? isOtpButtonEnabled,
    bool? isResetButtonEnabled,
    bool? isResendEnabled,
    int? resendSeconds,
    bool? hasOtpError,
    bool? navigateToLogin,
  }) {
    return ForgetPasswordState(
      base: base ?? this.base,
      step: step ?? this.step,
      otpErrorMessage: otpErrorMessage,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isEmailButtonEnabled: isEmailButtonEnabled ?? this.isEmailButtonEnabled,
      isOtpButtonEnabled: isOtpButtonEnabled ?? this.isOtpButtonEnabled,
      isResetButtonEnabled: isResetButtonEnabled ?? this.isResetButtonEnabled,
      isResendEnabled: isResendEnabled ?? this.isResendEnabled,
      resendSeconds: resendSeconds ?? this.resendSeconds,
      hasOtpError: hasOtpError ?? this.hasOtpError,
      navigateToLogin: navigateToLogin ?? this.navigateToLogin,
    );
  }

  @override
  List<Object?> get props => [
    base,
    step,
    otpErrorMessage,
    email,
    otp,
    password,
    confirmPassword,

    isEmailButtonEnabled,
    isOtpButtonEnabled,
    isResetButtonEnabled,

    isResendEnabled,
    resendSeconds,

    hasOtpError,
    navigateToLogin,
  ];
}
