import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/category_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_shimmer_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_parts_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_workouts_section.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/popular_training_card_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/popular_training_shimmer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      appBar: AppBar(
        title: Text('Let\'s Start Your Day'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // category
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: homeParts(
                context: context,
                title: 'Category',
                child: categoryContainer(
                  ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return Container(width: 1, color: AppColors.divider);
                    },
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return categoryCard(
                        title: category.title,
                        image: category.image,
                      );
                    },
                  ),
                ),
              ),
            ),

            // Recommendation To Day
            homeParts(
              context: context,
              title: 'Recommendation To Day',
              child: SizedBox(
                height: 130,
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.musclesState != current.musclesState,
                  builder: (context, state) {
                    if (state.musclesState.isLoading) {
                      return homeCardShimmer();
                    }
                    if (state.musclesState.data != null) {
                      final muscles = state.musclesState.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(margin: EdgeInsets.all(6));
                        },
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: muscles.length,
                        itemBuilder: (context, index) {
                          final muscle = muscles[index];
                          return homeCard(
                            image: muscle.image,
                            title: muscle.name,
                          );
                        },
                      );
                    }
                    if (state.musclesState.errorMessage != null) {
                      return Center(
                        child: Text(state.musclesState.errorMessage!),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            // workouts
            HomeWorkoutsSection(),

            // food
            homeParts(
              context: context,
              title: 'Food',
              child: SizedBox(height: 131),
            ),

            // popular training
            homeParts(
              context: context,
              title: "Popular Training",
              child: SizedBox(
                height: 200,
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.exerciseState != current.exerciseState,
                  builder: (context, state) {
                    if (state.exerciseState.isLoading) {
                      return popularTrainingShimmer();
                    }
                    if (state.exerciseState.data != null) {
                      final exercises = state.exerciseState.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(margin: EdgeInsets.all(6));
                        },
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return popularTrainingCard(
                            context: context,
                            exercise: exercise,
                          );
                        },
                      );
                    }
                    if (state.exerciseState.errorMessage != null) {
                      return Center(
                        child: Text(state.exerciseState.errorMessage!),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            Container(height: 300),
          ],
        ),
      ),
    );
  }
}