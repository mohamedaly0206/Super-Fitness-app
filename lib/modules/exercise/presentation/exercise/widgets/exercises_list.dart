import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_list_item.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/widgets/exercise_list_loading.dart';
import '../cubit/exercise_cubit.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ExerciseCubit cubit) => cubit.state.isLoadingExercises,
    );

    final exercises = context.select(
      (ExerciseCubit cubit) => cubit.state.exercises,
    );

    if (isLoading) {
      return ExerciseListLoading();
    }

    return Padding(
      padding: const EdgeInsets.only(
        right: AppPadding.p10,
        left: AppPadding.p10,
      ),
      child: CustomContainer(
        decoration: BoxDecoration(
          color: AppColors.glassFill,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(right: 0, left: 0),
          itemCount: exercises.length,
          separatorBuilder: (_, __) => Divider(color: AppColors.border),
          itemBuilder: (_, index) {
            return ExerciseListItem(exercise: exercises[index]);
          },
        ),
      ),
    );
  }
}
