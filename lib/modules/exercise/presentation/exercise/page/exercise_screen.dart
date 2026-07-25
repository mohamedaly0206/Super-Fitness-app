import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/widgets/app_error_widget.dart';
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_header.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercises_list.dart';

import '../cubit/exercise_cubit.dart';
import '../cubit/exercise_intent.dart';

class ExerciseScreen extends StatelessWidget {
  final String primeMoverMuscleId;

  const ExerciseScreen({super.key, required this.primeMoverMuscleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExerciseCubit>()
        ..doIntent(
          LoadExerciseScreenIntent(primeMoverMuscleId: primeMoverMuscleId),
        ),
      child: _ExerciseView(primeMoverMuscleId),
    );
  }
}

class _ExerciseView extends StatelessWidget {
  final String primeMoverMuscleId;

  const _ExerciseView(this.primeMoverMuscleId);

  @override
  Widget build(BuildContext context) {
    final baseState = context.select(
      (ExerciseCubit cubit) => cubit.state.baseState,
    );
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: Builder(
        builder: (_) {
          if (baseState.isLoading) {
            return AppLoadingWidget();
          }
          if (baseState.errorMessage != null) {
            return AppErrorWidget(
              errorMessage: baseState.errorMessage!,
              onRetry: () {
                context.read<ExerciseCubit>().doIntent(
                  LoadExerciseScreenIntent(
                    primeMoverMuscleId: primeMoverMuscleId,
                  ),
                );
              },
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExerciseHeader(),
              const AppSizedBox(height: 10),
              const Expanded(child: ExercisesList()),
            ],
          );
        },
      ),
    );
  }
}
