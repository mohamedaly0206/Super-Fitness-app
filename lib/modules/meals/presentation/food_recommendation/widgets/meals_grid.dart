import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/widgets/meal_card.dart';

class MealsGrid extends StatelessWidget {
  final List<MealEntity> meals;
  final ValueChanged<MealEntity> onMealTap;

  const MealsGrid({super.key, required this.meals, required this.onMealTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p100,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.s16,
        crossAxisSpacing: AppSize.s16,
        childAspectRatio: 1.0,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return MealCard(meal: meal, onTap: () => onMealTap(meal));
      },
    );
  }
}
