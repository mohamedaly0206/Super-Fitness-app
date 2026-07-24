import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';

abstract interface class MealsRepo {
  Future<BaseResponse<MealsDetailsEntity>> getMeals( String mealId);
}
