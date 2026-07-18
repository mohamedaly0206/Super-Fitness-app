import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';

import '../../../../../core/layout/app_padding.dart';
import '../../../../../core/layout/app_size.dart';
import '../../../../../core/localization_constants/auth_constants.dart';
import '../../../../../core/resources/app_png.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.login,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p46,
          horizontal: AppPadding.p16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppPng.logo, height: AppSize.s100, width: AppSize.s100)),
            Text(
              AuthConstants.heyThere,
              style: getRegularStyle(
                context: context,
                color: AppColors.textPrimary,
                fontSize: FontSizeManager.s18,
              ),
            ),
            Text(
              AuthConstants.welcomeBack,
              style: getBoldStyle(
                context: context,
                color: AppColors.textPrimary,
                fontSize: FontSizeManager.s20,
              ),
            ),
            const AppSizedBox(
              height: AppSize.s20,
            ),
            CustomContainer(
              borderRadius: AppSize.borderRadiusLarge,
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  Text(
                    AuthConstants.login,
                    style: getBoldStyle(
                      context: context,
                      color: AppColors.textPrimary,
                      fontSize: FontSizeManager.s24,
                    ),
                  ),
                  const AppSizedBox(height: AppSize.s20),
                  CustomTextField(),
                  const AppSizedBox(
                    height: AppSize.s12,
                  ),
                  CustomTextField(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
