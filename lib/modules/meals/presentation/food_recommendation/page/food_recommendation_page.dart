import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/app_error_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/grid_shimmer.dart';
import 'package:super_fitness_app/core/widgets/tab_bar_shimmer.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/cubit/food_recommendation_cubit.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/cubit/food_recommendation_event.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/cubit/food_recommendation_state.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/widgets/food_category_selector.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/widgets/food_recommendation_header.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/widgets/meals_grid.dart';

class FoodRecommendationPage extends StatelessWidget {
  final String? initialCategoryName;

  const FoodRecommendationPage({super.key, this.initialCategoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<FoodRecommendationCubit>()
            ..doEvent(LoadCategoriesEvent(initialCategoryName: initialCategoryName)),
      child: const _FoodRecommendationView(),
    );
  }
}

class _FoodRecommendationView extends StatefulWidget {
  const _FoodRecommendationView();

  @override
  State<_FoodRecommendationView> createState() =>
      _FoodRecommendationViewState();
}

class _FoodRecommendationViewState extends State<_FoodRecommendationView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: SafeArea(
        child: BlocBuilder<FoodRecommendationCubit, FoodRecommendationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FoodRecommendationHeader(),
                if (state.categories.isEmpty &&
                    (state is FoodRecommendationInitial ||
                        state is FoodRecommendationLoadingCategories)) ...[
                  const SizedBox(height: AppSize.s8),
                  const TabBarShimmer(),
                  const SizedBox(height: AppSize.s8),
                ] else if (state.categories.isNotEmpty) ...[
                  const SizedBox(height: AppSize.s8),
                  FoodCategorySelector(
                    categories: state.categories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (category) {
                      if (category.id == state.selectedCategory?.id) return;
                      context.read<FoodRecommendationCubit>().doEvent(
                        SelectCategoryEvent(category),
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s8),
                ],
                Expanded(child: _buildContent(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, FoodRecommendationState state) {
    switch (state) {
      case FoodRecommendationInitial():
      case FoodRecommendationLoadingCategories():
      case FoodRecommendationCategoriesLoaded():
      case FoodRecommendationLoadingMeals():
        return const GridShimmer();
      case FoodRecommendationMealsLoaded():
        return MealsGrid(
          meals: state.meals,
          onMealTap: (meal) {
            Navigator.pushNamed(
              context,
              Routes.foodDetails,
              arguments: meal.id,
            );
          },
        );
      case FoodRecommendationError():
        return AppErrorWidget(
          errorMessage: state.message,
          onRetry: () =>
              context.read<FoodRecommendationCubit>().doEvent(LoadCategoriesEvent()),
        );
    }
  }
}
