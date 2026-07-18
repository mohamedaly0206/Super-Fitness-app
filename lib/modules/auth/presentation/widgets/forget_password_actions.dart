import 'package:flutter/material.dart';

class ForgetPasswordActions {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onOtpChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;

  final VoidCallback onContinue;
  final VoidCallback onCompletedOtp;
  final VoidCallback onReset;
  final VoidCallback onResend;

  const ForgetPasswordActions({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,

    required this.onEmailChanged,
    required this.onOtpChanged,
    required this.onPasswordChanged,
    required this.onConfirmPasswordChanged,

    required this.onContinue,
    required this.onCompletedOtp,
    required this.onReset,
    required this.onResend,
  });
}
