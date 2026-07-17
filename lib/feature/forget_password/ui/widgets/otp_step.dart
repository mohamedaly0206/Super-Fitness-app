import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:super_fitness_app/core/localization_constants/forget_password_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_card.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_header.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/otp_input.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/otp_timer.dart';

class OtpStep extends StatelessWidget {
  final bool isLoading;
  final bool isButtonEnabled;
  final bool isResendEnabled;
  final int resendSeconds;
  final bool hasError;
  final ForgetPasswordActions actions;

  const OtpStep({
    super.key,
    required this.isLoading,
    required this.isButtonEnabled,
    required this.hasError,
    required this.isResendEnabled,
    required this.resendSeconds,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
        ForgetPasswordHeader(
          title: ForgetPasswordConstants.otpTitle,
          subtitle: ForgetPasswordConstants.otpSubtitle,
          titleStyle: getBoldStyle(
            context: context,
            fontSize: FontSizeManager.s24,
            color: AppColors.textPrimary,
          ),
          subtitleStyle: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s18,
            color: AppColors.textPrimary,
          ),
        ),
        // Card
        ForgetPasswordCard(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              OtpInput(hasError: hasError, onChanged: actions.onOtpChanged),
              if (hasError) ...[
                const AppSizedBox(height: 8),
                Text(
                  ForgetPasswordConstants.invalidCode,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.error,
                    fontSize: 13,
                  ),
                ),
              ],
              const AppSizedBox(height: 35),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const ButtonLoadingWidget()
                    : PrimaryButton(
                        text: ForgetPasswordConstants.confirm,
                        onTap: isButtonEnabled ? actions.onCompletedOtp : null,
                      ),
              ),
              const AppSizedBox(height: 10),
              Center(
                child: Text(
                  ForgetPasswordConstants.didntReceiveCode,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
              ),
              Center(
                child: isResendEnabled
                    ? GestureDetector(
                        onTap: actions.onResend,
                        child: Text(
                          ForgetPasswordConstants.resendCode,
                          style:
                              getTextWithLine(
                                context: context,
                                fontSize: 17,
                                color: AppColors.primaryLight,
                              ).copyWith(
                                fontWeight: FontWeightManager.bold,
                                decorationColor: AppColors.primaryLight,
                              ),
                        ),
                      )
                    : OtpTimer(seconds: resendSeconds),
              ),
            ],
          ),
        ),
      ],
    ).animate().fade(duration: 300.ms).slideY(begin: .05);
  }
}
