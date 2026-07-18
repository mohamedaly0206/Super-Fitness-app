import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';


class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppSizedBox(height: AppSize.s24),
        Image.asset(AppPng.logo2, height: AppSize.s100, width: AppSize.s100),
        const AppSizedBox(height: AppSize.s24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AuthConstants.heyThere,
            style: getRegularStyle(
              context: context,
              color: AppColors.textPrimary,
              fontSize: FontSizeManager.s18,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AuthConstants.createAnAccount,
            style: getBoldStyle(
              context: context,
              color: AppColors.textPrimary,
              fontSize: FontSizeManager.s20,
            ),
          ),
        ),
      ],
    );
  }
}
