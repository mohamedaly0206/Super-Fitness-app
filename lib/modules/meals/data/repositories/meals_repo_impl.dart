import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/repositories/meals_repo.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource mealsRemoteDataSource;

  MealsRepoImpl({required this.mealsRemoteDataSource});

  @override
  Future<BaseResponse<List<MealCategoryEntity>>> getCategories() async {
    final response = await mealsRemoteDataSource.getCategories();

    switch (response) {
      case SuccessBaseResponse<List<MealCategoryEntity>>():
        return SuccessBaseResponse<List<MealCategoryEntity>>(
          data: response.data,
        );
      case ErrorBaseResponse<List<MealCategoryEntity>>():
        return ErrorBaseResponse<List<MealCategoryEntity>>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<List<MealEntity>>> getMealsByCategory({
    required String category,
  }) async {
    final response = await mealsRemoteDataSource.getMealsByCategory(
      category: category,
    );

    switch (response) {
      case SuccessBaseResponse<List<MealEntity>>():
        return SuccessBaseResponse<List<MealEntity>>(data: response.data);
      case ErrorBaseResponse<List<MealEntity>>():
        return ErrorBaseResponse<List<MealEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<MealDetailsEntity>> getMealDetails({
    required String id,
  }) async {
    final response = await mealsRemoteDataSource.getMealDetails(id: id);

    switch (response) {
      case SuccessBaseResponse<MealDetailsEntity>():
        return SuccessBaseResponse<MealDetailsEntity>(data: response.data);
      case ErrorBaseResponse<MealDetailsEntity>():
        return ErrorBaseResponse<MealDetailsEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<MealsDetailsEntity>> getMeals(String id) async {
    final response = await mealsRemoteDataSource.getMeals(id);

    switch (response) {
      case SuccessBaseResponse():
        final entity = response.data.toDomain();
        return SuccessBaseResponse<MealsDetailsEntity>(data: entity);
      case ErrorBaseResponse():
        return ErrorBaseResponse<MealsDetailsEntity>(failure: response.failure);
    }
  }
}
