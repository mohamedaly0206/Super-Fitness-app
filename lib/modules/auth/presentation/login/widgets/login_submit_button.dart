import 'package:flutter/material.dart';
// تأكد من عمل import للمسار الصحيح الخاص بالـ AppLoadingWidget في مشروعك
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';

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
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      child: isLoading
          ? const AppLoadingWidget(size: 24, color: AppColors.surface)
          : Text(AuthConstants.login),
    );
  }
}
