import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_level_dto.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_level_entity.dart';

extension DifficultyLevelMapper on DifficultyLevelDto {
  DifficultyLevelEntity toDomain() {
    return DifficultyLevelEntity(id: id, name: name);
  }
}
