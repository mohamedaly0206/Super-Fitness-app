import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/cubit/exercise_details_state.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/widgets/exercise_details_body.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final ExerciseEntity exercise;

  const ExerciseDetailsPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExerciseDetailsCubit(),
      child: _ExerciseDetailsView(exercise: exercise),
    );
  }
}

class _ExerciseDetailsView extends StatelessWidget {
  final ExerciseEntity exercise;

  const _ExerciseDetailsView({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
      builder: (context, state) {
        return PopScope(
          canPop: !state.isPlayingVideo,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context.read<ExerciseDetailsCubit>().doEvent(
                CloseYoutubeVideoEvent(),
              );
            }
          },
          child: CustomScaffold(
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
              leading: Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: const CustomBackButton(),
              ),
            ),
            body: exerciseDetailsBody(context: context, exercise: exercise),
          ),
        );
      },
    );
  }
}
