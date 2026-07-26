import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

@LazySingleton(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient _mealsApiClient;

  MealsRemoteDataSourceImpl(this._mealsApiClient);

  @override
  Future<BaseResponse<List<MealCategoryEntity>>> getCategories() async {
    try {
      final response = await _mealsApiClient.getCategories();
      final entities =
          response.categories?.map((dto) => dto.toEntity()).toList() ?? [];
      return SuccessBaseResponse(data: entities);
    } catch (e) {
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
    }
  }

  @override
  Future<BaseResponse<List<MealEntity>>> getMealsByCategory({
    required String category,
  }) async {
    try {
      final response = await _mealsApiClient.getMealsByCategory(
        category: category,
      );
      final entities =
          response.meals?.map((dto) => dto.toEntity()).toList() ?? [];
      return SuccessBaseResponse(data: entities);
    } catch (e) {
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
    }
  }

  @override
  Future<BaseResponse<MealDetailsEntity>> getMealDetails({
    required String id,
  }) async {
    try {
      final response = await _mealsApiClient.getMealDetails(id: id);
      final entity = response.meals?.first.toEntity();
      if (entity != null) {
        return SuccessBaseResponse(data: entity);
      }
      return ErrorBaseResponse(
        failure: Failure(message: 'Meal details not found'),
      );
    } catch (e) {
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
    }
  }

  @override
  Future<BaseResponse<MealsDetailsDto>> getMeals(String id) async {
    try {
      final response = await _mealsApiClient.getMeals(id);
      return SuccessBaseResponse(data: response);
    } catch (e) {
      return ErrorBaseResponse(failure: Failure(message: e.toString()));
    }
  }
}
