import 'package:super_fitness_app/modules/profile/data/models/response/logout_response_dto.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';

extension LogoutResponseMapper on LogoutResponseDto {
  LogoutEntity toDomain() {
    return LogoutEntity(message: message);
  }
}
