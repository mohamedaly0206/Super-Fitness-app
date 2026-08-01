import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/cubit/home_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/category_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_shimmer_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_card_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_header.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_parts_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/home_workouts_section.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/popular_training_card_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/popular_training_shimmer_widget.dart';
import 'package:super_fitness_app/modules/exercise/presentation/home/widgets/see_all_text.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // home header
              HomeHeader(),

              // category
              homeParts(
                context: context,
                title: context.category,
                child: categoryContainer(
                  ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return Container(width: 1, color: AppColors.divider);
                    },
                    itemCount: categoriesBuilder(context).length,
                    itemBuilder: (context, index) {
                      final category = categoriesBuilder(context)[index];
                      return categoryCard(
                        title: category.title,
                        image: category.image,
                      );
                    },
                  ),
                ),
              ),

              // Recommendation To Day
              homeParts(
                context: context,
                title: context.recommendationToday,
                child: SizedBox(
                  height: AppSize.s130,
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
                            return Container(
                              margin: EdgeInsets.all(AppPadding.p8),
                            );
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
                title: context.recommendationForYou,
                trailing: SeeAllText(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.foodRecommendation);
                  },
                ),
                child: SizedBox(
                  height: AppSize.s131,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.foodCategoriesState !=
                        current.foodCategoriesState,
                    builder: (context, state) {
                      if (state.foodCategoriesState.isLoading) {
                        return homeCardShimmer();
                      }
                      if (state.foodCategoriesState.data != null) {
                        final categories = state.foodCategoriesState.data!;
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(AppPadding.p8),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return HomeCardWidget(
                              image: category.thumbnail,
                              title: category.name,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.foodRecommendation,
                                  arguments: category.name,
                                );
                              },
                            );
                          },
                        );
                      }
                      if (state.foodCategoriesState.errorMessage != null) {
                        return Center(
                          child: Text(state.foodCategoriesState.errorMessage!),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),

              // popular training
              homeParts(
                context: context,
                title: context.popularTraining,
                child: SizedBox(
                  height: AppSize.s200,
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
                            return Container(
                              margin: EdgeInsets.all(AppPadding.p8),
                            );
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

              Container(height: AppSize.s90),
            ],
          ),
        ),
      ),
    );
  }
}
