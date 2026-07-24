import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/localization_constants/error_massage_constants.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

@LazySingleton(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient mealsApiClient;

  MealsRemoteDataSourceImpl({required this.mealsApiClient});

  @override
  Future<BaseResponse<List<MealCategoryEntity>>> getCategories() async {
    try {
      final response = await mealsApiClient.getCategories();
      return SuccessBaseResponse<List<MealCategoryEntity>>(
        data: response.categories?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MealCategoryEntity>>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<List<MealEntity>>> getMealsByCategory({
    required String category,
  }) async {
    try {
      final response = await mealsApiClient.getMealsByCategory(
        category: category,
      );
      return SuccessBaseResponse<List<MealEntity>>(
        data: response.meals?.map((e) => e.toEntity()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MealEntity>>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<MealDetailsEntity>> getMealDetails({
    required String id,
  }) async {
    try {
      final response = await mealsApiClient.getMealDetails(id: id);
      final meal = response.meals?.firstOrNull;
      if (meal == null) {
        return ErrorBaseResponse<MealDetailsEntity>(
          failure: Failure(message: ErrorConstants.unexpectedError),
        );
      }
      return SuccessBaseResponse<MealDetailsEntity>(data: meal.toEntity());
    } catch (e) {
      return ErrorBaseResponse<MealDetailsEntity>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
