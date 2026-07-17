import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/forget_password_constants.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_step.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/email_step.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/otp_step.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/reset_password_step.dart';

class ForgetPasswordStepSwitcher extends StatelessWidget {
  final ForgetPasswordState state;
  final ForgetPasswordActions actions;

  const ForgetPasswordStepSwitcher({
    super.key,
    required this.state,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(.08, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _currentStep(),
    );
  }

  Widget _currentStep() {
    switch (state.step) {
      case ForgetPasswordStep.email:
        return EmailStep(
          key: const ValueKey(ForgetPasswordConstants.emailKey),
          isLoading: state.base.isLoading,
          isButtonEnabled: state.isEmailButtonEnabled,
          actions: actions,
        );

      case ForgetPasswordStep.otp:
        return OtpStep(
          key: const ValueKey(ForgetPasswordConstants.otpKey),
          isLoading: state.base.isLoading,
          isButtonEnabled: state.isOtpButtonEnabled,
          hasError: state.hasOtpError,
          isResendEnabled: state.isResendEnabled,
          resendSeconds: state.resendSeconds,
          actions: actions,
        );

      case ForgetPasswordStep.resetPassword:
        return ResetPasswordStep(
          key: const ValueKey(ForgetPasswordConstants.resetKey),
          isLoading: state.base.isLoading,
          isButtonEnabled: state.isResetButtonEnabled,
          actions: actions,
        );

      case ForgetPasswordStep.success:
        return const SizedBox.shrink();
    }
  }
}
