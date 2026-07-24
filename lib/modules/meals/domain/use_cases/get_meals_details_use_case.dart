import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/repositories/meals_repo.dart';

@injectable
class GetMealsDetailsUseCase {
  final MealsRepo mealsRepo;
  GetMealsDetailsUseCase({required this.mealsRepo});

  Future<BaseResponse<MealsDetailsEntity>> call(String mealId) => mealsRepo.getMeals(mealId);
}