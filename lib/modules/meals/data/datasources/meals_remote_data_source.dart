import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';

abstract interface class MealsRemoteDataSource {
  Future<BaseResponse<MealsDetailsDto>> getMeals(String mealId);
}
