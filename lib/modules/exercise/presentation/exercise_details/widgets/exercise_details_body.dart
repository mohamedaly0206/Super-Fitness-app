import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/widgets/exercise_details_top_header.dart';

Widget exerciseDetailsBody({
  required BuildContext context,
  required ExerciseEntity exercise,
}) {
  return Column(
    children: [
      ExerciseDetailsTopHeader(exercise: exercise),

      // Details below video
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + Difficulty
              Row(
                children: [
                  Expanded(
                    child: Text(
                      exercise.exercise,
                      style: getSemiBoldStyle(
                        context: context,
                        fontSize: FontSizeManager.s20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p12,
                      vertical: AppPadding.p8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        AppSize.borderRadiusOutlined,
                      ),
                    ),
                    child: Text(
                      exercise.difficultyLevel,
                      style: TextStyle(
                        fontSize: FontSizeManager.s12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSize.s20),

              // Key Info Cards
              _infoRow(
                context,
                icon: Icons.fitness_center,
                label: context.targetMuscle,
                value: exercise.targetMuscleGroup,
              ),
              const SizedBox(height: AppSize.s10),
              _infoRow(
                context,
                icon: Icons.accessibility_new,
                label: context.primaryMuscle,
                value: exercise.primeMoverMuscle,
              ),
              const SizedBox(height: AppSize.s10),
              _infoRow(
                context,
                icon: Icons.build,
                label: context.equipment,
                value: exercise.primaryEquipment,
              ),
              const SizedBox(height: AppSize.s10),
              _infoRow(
                context,
                icon: Icons.swap_horiz,
                label: context.forceType,
                value: exercise.forceType,
              ),
              const SizedBox(height: AppSize.s10),
              _infoRow(
                context,
                icon: Icons.settings,
                label: context.mechanics,
                value: exercise.mechanics,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _infoRow(
  BuildContext context, {
  required IconData icon,
  required String label,
  required String value,
}) {
  return CustomContainer(
    padding: const EdgeInsets.symmetric(
      horizontal: AppPadding.p14,
      vertical: AppPadding.p12,
    ),
    borderRadius: AppSize.borderRadiusTag,
    child: Row(
      children: [
        Icon(icon, size: AppSize.s20, color: AppColors.primary),
        const SizedBox(width: AppSize.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: FontSizeManager.s11,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: AppSize.s2),
              Text(
                value.isNotEmpty ? value : context.na,
                style: TextStyle(
                  fontSize: FontSizeManager.s14,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
