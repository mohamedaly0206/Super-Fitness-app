import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppPadding.p16,
        bottom: AppPadding.p16,
        left: AppPadding.p20,
        right: AppPadding.p20,
      ),
      child: Text(
        AppStrings.profile,
        textAlign: TextAlign.center,
        style: getSemiBoldStyle(
          context: context,
          fontSize: AppSize.s24,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}