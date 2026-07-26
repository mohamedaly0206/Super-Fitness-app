import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/widgets/food_category_chip.dart';

class FoodCategorySelector extends StatelessWidget {
  final List<MealCategoryEntity> categories;
  final MealCategoryEntity? selectedCategory;
  final ValueChanged<MealCategoryEntity> onCategorySelected;

  const FoodCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSize.s24),
        itemBuilder: (context, index) {
          final category = categories[index];
          return FoodCategoryChip(
            label: category.name,
            isSelected: category.id == selectedCategory?.id,
            onTap: () => onCategorySelected(category),
          );
        },
      ),
    );
  }
}
