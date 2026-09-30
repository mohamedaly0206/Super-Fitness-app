import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';

sealed class FoodRecommendationEvent {}

class LoadCategoriesEvent extends FoodRecommendationEvent {
  final String? initialCategoryName;
  LoadCategoriesEvent({this.initialCategoryName});
}

class SelectCategoryEvent extends FoodRecommendationEvent {
  final MealCategoryEntity category;
  SelectCategoryEvent(this.category);
}
