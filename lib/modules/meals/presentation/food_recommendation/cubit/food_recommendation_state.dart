import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

sealed class FoodRecommendationState extends Equatable {
  const FoodRecommendationState();

  List<MealCategoryEntity> get categories => const [];
  MealCategoryEntity? get selectedCategory => null;

  @override
  List<Object?> get props => [];
}

class FoodRecommendationInitial extends FoodRecommendationState {
  const FoodRecommendationInitial();
}

class FoodRecommendationLoadingCategories extends FoodRecommendationState {
  const FoodRecommendationLoadingCategories();
}

class FoodRecommendationCategoriesLoaded extends FoodRecommendationState {
  @override
  final List<MealCategoryEntity> categories;
  @override
  final MealCategoryEntity selectedCategory;

  const FoodRecommendationCategoriesLoaded({
    required this.categories,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [categories, selectedCategory];
}

class FoodRecommendationLoadingMeals extends FoodRecommendationState {
  @override
  final List<MealCategoryEntity> categories;
  @override
  final MealCategoryEntity selectedCategory;

  const FoodRecommendationLoadingMeals({
    required this.categories,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [categories, selectedCategory];
}

class FoodRecommendationMealsLoaded extends FoodRecommendationState {
  @override
  final List<MealCategoryEntity> categories;
  @override
  final MealCategoryEntity selectedCategory;
  final List<MealEntity> meals;

  const FoodRecommendationMealsLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.meals,
  });

  @override
  List<Object?> get props => [categories, selectedCategory, meals];
}

class FoodRecommendationError extends FoodRecommendationState {
  final String message;
  @override
  final List<MealCategoryEntity> categories;
  @override
  final MealCategoryEntity? selectedCategory;

  const FoodRecommendationError({
    required this.message,
    this.categories = const [],
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [message, categories, selectedCategory];
}
