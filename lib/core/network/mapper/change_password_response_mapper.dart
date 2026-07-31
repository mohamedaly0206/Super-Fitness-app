import 'package:super_fitness_app/modules/profile/data/models/response/change_password_response_dto.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/change_password_entity.dart';

extension ChangePasswordResponseMapper on ChangePasswordResponseDto {
  ChangePasswordEntity toDomain() {
    return ChangePasswordEntity(message: message, token: token);
  }
}
