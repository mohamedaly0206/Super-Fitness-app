import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';


//static remove it
class RegisterContinuationPlaceholderPage extends StatelessWidget {
  const RegisterContinuationPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.onboarding,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            AuthConstants.registerContinuationPlaceholder,
            textAlign: TextAlign.center,
            style: getMediumStyle(context: context, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
