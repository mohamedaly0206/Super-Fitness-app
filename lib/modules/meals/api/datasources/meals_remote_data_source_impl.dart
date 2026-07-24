import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';
import '../../data/datasources/meals_remote_data_source.dart';

@LazySingleton(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsApiClient _mealsApiClient;
  const MealsRemoteDataSourceImpl(this._mealsApiClient);
  @override
  Future<BaseResponse<MealsDetailsDto>> getMeals(String mealId) async {
    try {
      final response = await _mealsApiClient.getMeals(mealId);
      return SuccessBaseResponse<MealsDetailsDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<MealsDetailsDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
