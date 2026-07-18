import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class LoginRedirectRow extends StatelessWidget {
  final VoidCallback onLoginTap;

  const LoginRedirectRow({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLoginTap,
      child: RichText(
        text: TextSpan(
          text: '${AuthConstants.dontHaveAccount} ',
          style: getRegularStyle(context: context, color: AppColors.textPrimary),
          children: [
            TextSpan(
              text: AuthConstants.register,
              style: getSemiBoldStyle(
                context: context,
                color: AppColors.primary,
              ).copyWith(decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}