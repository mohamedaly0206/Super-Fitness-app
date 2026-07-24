import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/use_cases/get_categories_use_case.dart';
import 'package:super_fitness_app/modules/meals/domain/use_cases/get_meals_by_category_use_case.dart';

part 'food_recommendation_state.dart';

@Injectable()
class FoodRecommendationCubit extends Cubit<FoodRecommendationState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetMealsByCategoryUseCase getMealsByCategoryUseCase;

  FoodRecommendationCubit({
    required this.getCategoriesUseCase,
    required this.getMealsByCategoryUseCase,
  }) : super(const FoodRecommendationInitial());

  Future<void> loadCategories() async {
    emit(const FoodRecommendationLoadingCategories());

    final response = await getCategoriesUseCase();
    switch (response) {
      case SuccessBaseResponse<List<MealCategoryEntity>>():
        final categories = response.data;
        if (categories.isEmpty) {
          emit(const FoodRecommendationError(message: 'No categories found'));
          return;
        }
        final firstCategory = categories.first;
        emit(
          FoodRecommendationCategoriesLoaded(
            categories: categories,
            selectedCategory: firstCategory,
          ),
        );
        await selectCategory(firstCategory);
      case ErrorBaseResponse<List<MealCategoryEntity>>():
        emit(FoodRecommendationError(message: response.failure.message));
    }
  }

  Future<void> selectCategory(MealCategoryEntity category) async {
    final categories = state.categories;

    emit(
      FoodRecommendationLoadingMeals(
        categories: categories,
        selectedCategory: category,
      ),
    );

    final response = await getMealsByCategoryUseCase(category: category.name);
    switch (response) {
      case SuccessBaseResponse<List<MealEntity>>():
        emit(
          FoodRecommendationMealsLoaded(
            categories: categories,
            selectedCategory: category,
            meals: response.data,
          ),
        );
      case ErrorBaseResponse<List<MealEntity>>():
        emit(
          FoodRecommendationError(
            categories: categories,
            selectedCategory: category,
            message: response.failure.message,
          ),
        );
    }
  }
}
