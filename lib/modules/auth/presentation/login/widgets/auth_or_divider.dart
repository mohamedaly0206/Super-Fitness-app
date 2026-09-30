import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: AppSize.s64,
          child: Divider(color: AppColors.borderDefault),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Text(
            AuthConstants.or,
            style: getRegularStyle(
              context: context,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(
          width: AppSize.s64,
          child: Divider(color: AppColors.borderDefault),
        ),
      ],
    );
  }
}
