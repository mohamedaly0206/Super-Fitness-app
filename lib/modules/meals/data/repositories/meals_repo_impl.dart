import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meals_details_entity.dart';
import '../../domain/repositories/meals_repo.dart';

@Injectable(as: MealsRepo)
class MealsRepoImpl implements MealsRepo {
  final MealsRemoteDataSource _mealsRemoteDataSource;

  MealsRepoImpl(this._mealsRemoteDataSource);
  @override
  Future<BaseResponse<MealsDetailsEntity>> getMeals(String mealId) async {
    final response = await _mealsRemoteDataSource.getMeals(mealId);
    switch (response) {
      case SuccessBaseResponse<MealsDetailsDto>():
        return SuccessBaseResponse<MealsDetailsEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<MealsDetailsDto>():
        return ErrorBaseResponse<MealsDetailsEntity>(failure: response.failure);
    }
  }
}
