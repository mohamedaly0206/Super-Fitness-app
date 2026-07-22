import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/repositories/meals_repo.dart';

@Injectable()
class GetMealDetailsUseCase {
  final MealsRepo _mealsRepo;

  GetMealDetailsUseCase(this._mealsRepo);

  Future<BaseResponse<MealDetailsEntity>> call({required String id}) async {
    return await _mealsRepo.getMealDetails(id: id);
  }
}
