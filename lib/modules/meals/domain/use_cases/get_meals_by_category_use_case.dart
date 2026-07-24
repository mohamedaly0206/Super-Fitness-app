import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/repositories/meals_repo.dart';

@Injectable()
class GetMealsByCategoryUseCase {
  final MealsRepo _mealsRepo;

  GetMealsByCategoryUseCase(this._mealsRepo);

  Future<BaseResponse<List<MealEntity>>> call({
    required String category,
  }) async {
    return await _mealsRepo.getMealsByCategory(category: category);
  }
}
