import 'package:injectable/injectable.dart';
import '../../domain/repositories/meals_repo.dart';

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
        return ErrorBaseResponse<MealDetailsEntity>(
          failure: response.failure,
        );
    }
  }
}
