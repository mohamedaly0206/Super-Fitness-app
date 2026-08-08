import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/cubit/app_sections_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_state.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/see_all_text.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_shimmer_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_tab_shimmer_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_event.dart'
    hide GetMusclesByGroupEvent;

class HomeWorkoutsSection extends StatefulWidget {
  const HomeWorkoutsSection({super.key});

  @override
  State<HomeWorkoutsSection> createState() => _HomeWorkoutsSectionState();
}

class _HomeWorkoutsSectionState extends State<HomeWorkoutsSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
          prev.muscleGroupsState.data != curr.muscleGroupsState.data,
      builder: (context, state) {
        if (state.muscleGroupsState.isLoading) {
          return homeTabShimmer();
        }
        if (state.muscleGroupsState.errorMessage != null) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(state.muscleGroupsState.errorMessage!),
          );
        }
        final groups = state.muscleGroupsState.data;
        if (groups == null || groups.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p8,
              ),
              child: Row(
                children: [
                  Text(
                    context.upcomingWorkouts,
                    style: getSemiBoldStyle(
                      context: context,
                      fontSize: FontSizeManager.s18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  SeeAllText(
                    onTap: () {
                      context.read<WorkoutsCubit>().doEvent(
                        SetSelectedGroupEvent(
                          groupId: groups[_selectedIndex].id,
                        ),
                      );
                      context.read<AppSectionsCubit>().doEvent(ChangeSectionEvent(1));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemCount: groups.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSize.s10),
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      if (_selectedIndex != index) {
                        setState(() => _selectedIndex = index);
                        context.read<HomeCubit>().doEvent(
                          GetMusclesByGroupEvent(
                            muscleGroupId: groups[index].id,
                          ),
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p20,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          AppSize.borderRadiusPill,
                        ),
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeManager.s14,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                        child: Text(groups[index].name),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSize.s5),
            SizedBox(
              height: AppSize.s130,
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (prev, curr) =>
                    prev.musclesByGroupState != curr.musclesByGroupState,
                builder: (context, state) {
                  if (state.musclesByGroupState.isLoading) {
                    return homeCardShimmer();
                  }
                  if (state.musclesByGroupState.data != null) {
                    final muscles = state.musclesByGroupState.data!;
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(margin: EdgeInsets.all(AppPadding.p8));
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: muscles.length,
                      itemBuilder: (context, index) {
                        final muscle = muscles[index];
                        return HomeCardWidget(
                          image: muscle.image,
                          title: muscle.name,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.exercises,
                              arguments: muscle.id,
                            );
                          },
                        );
                      },
                    );
                  }
                  if (state.musclesByGroupState.errorMessage != null) {
                    return Center(
                      child: Text(state.musclesByGroupState.errorMessage!),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
