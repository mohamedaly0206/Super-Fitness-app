import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/widgets/exercise_details_body.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final ExerciseEntity exercise;

  const ExerciseDetailsPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      appBar: AppBar(
        title: Text(
          exercise.exercise,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: exerciseDetailsBody(context: context, exercise: exercise),
    );
  }
}