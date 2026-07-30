import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponse<LogoutEntity>> logout();
}
