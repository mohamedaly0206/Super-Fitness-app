import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/localization_constants/error_massage_constants.dart';
import 'package:super_fitness_app/modules/meals/api/api_client/meals_api_client.dart';
import 'package:super_fitness_app/modules/meals/data/datasources/meals_remote_data_source.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_details_entity.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';

@LazySingleton(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  // TODO: Implement
}
