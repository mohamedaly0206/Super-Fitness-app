import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';

class LoginSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const LoginSubmitButton({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ButtonLoadingWidget();
    }
    return PrimaryButton(
      text: AuthConstants.login,
      onTap: onTap,
    );
  }
}
