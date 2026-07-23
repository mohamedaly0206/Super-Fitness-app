import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_event.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/widgets/workout_grid_item.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/widgets/workouts_tab_shimmer.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/widgets/workouts_grid_shimmer.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<WorkoutsCubit>().doEvent(GetMuscleGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Workouts',
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
      body: BlocBuilder<WorkoutsCubit, WorkoutsState>(
        buildWhen: (prev, curr) =>
            prev.muscleGroupsState.data != curr.muscleGroupsState.data,
        builder: (context, state) {
          if (state.muscleGroupsState.isLoading) {
            return const WorkoutsTabShimmer();
          }
          if (state.muscleGroupsState.errorMessage != null) {
            return Center(
              child: Text(state.muscleGroupsState.errorMessage!),
            );
          }
          final groups = state.muscleGroupsState.data;
          if (groups == null || groups.isEmpty) {
            return const Center(child: Text('No muscle groups'));
          }

          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: groups.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
              const SizedBox(height: 10),
              Expanded(
                child: _buildMuscleGrid(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMuscleGrid() {
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      buildWhen: (prev, curr) => prev.musclesState != curr.musclesState,
      builder: (context, state) {
        if (state.musclesState.isLoading) {
          return const WorkoutsGridShimmer();
        }
        if (state.musclesState.errorMessage != null) {
          return Center(child: Text(state.musclesState.errorMessage!));
        }
        final muscles = state.musclesState.data;
        if (muscles == null || muscles.isEmpty) {
          return const Center(child: Text('No muscles'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: muscles.length,
          itemBuilder: (context, index) {
            final muscle = muscles[index];
            return WorkoutGridItem(
              image: muscle.image,
              title: muscle.name,
            );
          },
        );
      },
    );
  }
}