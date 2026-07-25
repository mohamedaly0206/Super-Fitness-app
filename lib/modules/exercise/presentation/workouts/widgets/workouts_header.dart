import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';

class WorkoutsHeader extends StatelessWidget {
  const WorkoutsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppPadding.p16,
        bottom: AppPadding.p16,
        left: AppPadding.p20,
        right: AppPadding.p20,
      ),
      child: Text(
        context.workouts,
        style: getBoldStyle(
          context: context,
          fontSize: AppSize.s28,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
