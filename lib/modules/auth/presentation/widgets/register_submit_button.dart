import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';


class RegisterSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const RegisterSubmitButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ButtonLoadingWidget()
        : PrimaryButton(text: AuthConstants.register, onTap: onTap);
  }
}
