import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/utils/app_validator.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';


class RegisterFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: firstNameController,
          hintText: AuthConstants.firstName,
          keyboardType: TextInputType.name,
          prefixIcon: const Icon(Icons.person_outline),
          validator: AppValidator.name,
        ),
        const AppSizedBox(height: AppSize.s12),
        CustomTextField(
          controller: lastNameController,
          hintText: AuthConstants.lastName,
          keyboardType: TextInputType.name,
          prefixIcon: const Icon(Icons.person_outline),
          validator: AppValidator.name,
        ),
        const AppSizedBox(height: AppSize.s12),
        CustomTextField(
          controller: emailController,
          hintText: AuthConstants.email,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.mail_outline),
          validator: AppValidator.email,
        ),
        const AppSizedBox(height: AppSize.s12),
        CustomTextField(
          controller: passwordController,
          hintText: AuthConstants.password,
          isPassword: true,
          prefixIcon: const Icon(Icons.lock_outline),
          validator: AppValidator.password,
        ),
      ],
    );
  }
}
