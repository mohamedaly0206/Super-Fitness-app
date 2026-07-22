import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/repositories/meals_repo.dart';

@Injectable()
class GetCategoriesUseCase {
  final MealsRepo _mealsRepo;

  GetCategoriesUseCase(this._mealsRepo);

  Future<BaseResponse<List<MealCategoryEntity>>> call() async {
    return await _mealsRepo.getCategories();
  }
}
