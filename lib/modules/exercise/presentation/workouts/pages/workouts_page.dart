import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/app_router.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/core/widgets/grid_shimmer.dart';
import 'package:super_fitness_app/core/widgets/tab_bar_shimmer.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/widgets/workout_grid_item.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/widgets/workouts_header.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  int _selectedIndex = 0;
  bool _didFetchGroups = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetchGroups) {
      _didFetchGroups = true;
      final initialId = ModalRoute.of(context)?.settings.arguments as String?;
      context.read<WorkoutsCubit>().doEvent(
        GetMuscleGroupsEvent(initialMuscleGroupId: initialId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: Column(
        children: [
          const WorkoutsHeader(),
          Expanded(
            child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
              buildWhen: (prev, curr) =>
                  prev.muscleGroupsState.data != curr.muscleGroupsState.data ||
                  prev.selectedGroupId != curr.selectedGroupId,
              builder: (context, state) {
                if (state.muscleGroupsState.isLoading) {
                  return const Column(
                    children: [
                      TabBarShimmer(),
                      SizedBox(height: AppSize.s10),
                      Expanded(child: GridShimmer()),
                    ],
                  );
                }
                if (state.muscleGroupsState.errorMessage != null) {
                  return Center(
                    child: Text(state.muscleGroupsState.errorMessage!),
                  );
                }
                final groups = state.muscleGroupsState.data;
                if (groups == null || groups.isEmpty) {
                  return Center(child: Text(context.noMuscleGroups));
                }

                if (state.selectedGroupId != null) {
                  final idx = groups.indexWhere(
                    (g) => g.id == state.selectedGroupId,
                  );
                  if (idx != -1 && _selectedIndex != idx) {
                    _selectedIndex = idx;
                  }
                }

                return Column(
                  children: [
                    SizedBox(
                      height: AppSize.s50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8,
                        ),
                        itemCount: groups.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: AppSize.s10),
                        itemBuilder: (context, index) {
                          final isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              if (_selectedIndex != index) {
                                setState(() => _selectedIndex = index);
                                context.read<WorkoutsCubit>().doEvent(
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
                                horizontal: AppPadding.p16,
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
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                                child: Text(groups[index].name),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                    Expanded(child: _buildMuscleGrid()),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleGrid() {
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      buildWhen: (prev, curr) => prev.musclesState != curr.musclesState,
      builder: (context, state) {
        if (state.musclesState.isLoading) {
          return const GridShimmer();
        }
        if (state.musclesState.errorMessage != null) {
          return Center(child: Text(state.musclesState.errorMessage!));
        }
        final muscles = state.musclesState.data;
        if (muscles == null || muscles.isEmpty) {
          return Center(child: Text(context.noMuscles));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppPadding.p12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSize.s12,
            mainAxisSpacing: AppSize.s12,
            childAspectRatio: 1.0,
          ),
          itemCount: muscles.length,
          itemBuilder: (context, index) {
            final muscle = muscles[index];
            return WorkoutGridItem(
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
      },
    );
  }
}
