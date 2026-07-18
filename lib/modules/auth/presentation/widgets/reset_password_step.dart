import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/localization_constants/forget_password_constants.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/utils/app_validator.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/widgets/forget_password_actions.dart';
import 'package:super_fitness_app/modules/auth/presentation/widgets/forget_password_card.dart';
import 'package:super_fitness_app/modules/auth/presentation/widgets/forget_password_header.dart';

class ResetPasswordStep extends StatelessWidget {
  final bool isLoading;
  final bool isButtonEnabled;
  final ForgetPasswordActions actions;

  const ResetPasswordStep({
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
          title: ForgetPasswordConstants.passwordSubtitle,
          subtitle: ForgetPasswordConstants.createNewPassword,
        ),
        ForgetPasswordCard(
          body: Column(
            spacing: 24,
            children: [
              CustomTextField(
                prefixIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(AppSvg.lock),
                ),
                controller: actions.passwordController,
                hintText: ForgetPasswordConstants.passwordHint,
                isPassword: true,
                validator: AppValidator.password,
                textInputAction: TextInputAction.next,
                onChanged: actions.onPasswordChanged,
              ),
              CustomTextField(
                prefixIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(AppSvg.lock),
                ),
                controller: actions.confirmPasswordController,
                hintText: ForgetPasswordConstants.confirmPasswordHint,
                isPassword: true,
                validator: (value) => AppValidator.confirmPassword(
                  value,
                  actions.passwordController.text,
                ),
                textInputAction: TextInputAction.done,
                onChanged: actions.onConfirmPasswordChanged,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const ButtonLoadingWidget()
                    : PrimaryButton(
                        text: ForgetPasswordConstants.done,
                        onTap: isButtonEnabled ? actions.onReset : null,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
