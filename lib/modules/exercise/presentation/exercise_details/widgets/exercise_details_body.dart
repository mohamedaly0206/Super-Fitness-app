import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
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
          padding: const EdgeInsets.all(16),
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
                  const SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      exercise.difficultyLevel,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Key Info Cards
              _infoRow(
                context,
                icon: Icons.fitness_center,
                label: 'Target Muscle',
                value: exercise.targetMuscleGroup,
              ),
              const SizedBox(height: 10),
              _infoRow(
                context,
                icon: Icons.accessibility_new,
                label: 'Primary Muscle',
                value: exercise.primeMoverMuscle,
              ),
              const SizedBox(height: 10),
              _infoRow(
                context,
                icon: Icons.build,
                label: 'Equipment',
                value: exercise.primaryEquipment,
              ),
              const SizedBox(height: 10),
              _infoRow(
                context,
                icon: Icons.swap_horiz,
                label: 'Force Type',
                value: exercise.forceType,
              ),
              const SizedBox(height: 10),
              _infoRow(
                context,
                icon: Icons.settings,
                label: 'Mechanics',
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
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    borderRadius: 14,
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'N/A',
                style: TextStyle(
                  fontSize: 14,
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