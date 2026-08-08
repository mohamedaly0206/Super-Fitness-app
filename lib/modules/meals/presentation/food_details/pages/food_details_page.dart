import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/meals_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_cubit.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_event.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_state.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/food_details_shimmer.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/food_details_top_header.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/widgets/ingredients_widget.dart';

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key, required this.mealId});
  final String mealId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<FoodDetailsCubit>()
            ..doEvent(GetMealsDetailsEvent(mealId: mealId)),
      child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
        builder: (context, state) {
          return PopScope(
            canPop: !state.isPlayingVideo,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                context.read<FoodDetailsCubit>().doEvent(
                  CloseYoutubeVideoEvent(),
                );
              }
            },
            child: CustomScaffold(
              background: Backgrounds.homeAndSelectDetailsExercise,
              body: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
                builder: (context, state) {
                  return state.getFoodDetailsState.isLoading
                      ? const FoodDetailsShimmer()
                      : state.getFoodDetailsState.errorMessage != null
                      ? Center(
                          child: Text(state.getFoodDetailsState.errorMessage!),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FoodDetailsTopHeader(
                                meal:
                                    state.getFoodDetailsState.data.meals?.first,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.ingredients,
                                      style: getBoldStyle(
                                        context: context,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontSize: FontSizeManager.s20,
                                      ),
                                    ),
                                    const SizedBox(height: AppSize.s8),
                                    // REMOVED Expanded() here:
                                    IngrediEntsWidget(
                                      ingredients: state.validIngredients,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
