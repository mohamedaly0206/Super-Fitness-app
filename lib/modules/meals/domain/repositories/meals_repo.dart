import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

abstract class MealsRepo {
  Future<BaseResponse<List<MealCategoryEntity>>> getCategories();
  Future<BaseResponse<List<MealEntity>>> getMealsByCategory({
    required String category,
  });
  Future<BaseResponse<MealDetailsEntity>> getMealDetails({required String id});
}
