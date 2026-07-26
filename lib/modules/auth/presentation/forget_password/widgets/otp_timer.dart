import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/forget_password_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class OtpTimer extends StatelessWidget {
  final int seconds;

  const OtpTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: getRegularStyle(
          context: context,
          color: AppColors.textSecondary,
        ),
        children: [
          TextSpan(text: ForgetPasswordConstants.resendIn),
          TextSpan(
            text: "$seconds",
            style: getSemiBoldStyle(context: context, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
