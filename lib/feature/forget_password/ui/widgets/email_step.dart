import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:super_fitness_app/core/localization_constants/forget_password_constants.dart';
import 'package:super_fitness_app/core/utils/app_validator.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_card.dart';
import 'package:super_fitness_app/feature/forget_password/ui/widgets/forget_password_header.dart';

class EmailStep extends StatelessWidget {
  final bool isLoading;
  final bool isButtonEnabled;
  final ForgetPasswordActions actions;

  const EmailStep({
    super.key,
    required this.isLoading,
    required this.isButtonEnabled,
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
          title: ForgetPasswordConstants.enterYourEmail,
          subtitle: ForgetPasswordConstants.forgetPassword,
        ),
        // Card
        ForgetPasswordCard(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              CustomTextField(
                controller: actions.emailController,
                hintText: ForgetPasswordConstants.emailHint,
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
                textInputAction: TextInputAction.done,
                onChanged: actions.onEmailChanged,
              ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const ButtonLoadingWidget()
                    : PrimaryButton(
                        text: ForgetPasswordConstants.sendOtp,
                        onTap: isButtonEnabled ? actions.onContinue : null,
                      ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fade(duration: 300.ms).slideY(begin: .05);
  }
}
