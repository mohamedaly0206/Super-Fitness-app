import 'package:super_fitness_app/core/network/mapper/difficulty_level_mapper.dart';
import 'package:super_fitness_app/modules/exercise/data/models/response/difficulty_levels_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/difficulty_levels_response_entity.dart';

extension DifficultyLevelsResponseMapper on DifficultyLevelsResponseDto {
  DifficultyLevelsResponseEntity toDomain() {
    return DifficultyLevelsResponseEntity(
      message: message,
      totalLevels: totalLevels,
      difficultyLevels: difficultyLevels.map((e) => e.toDomain()).toList(),
    );
  }
}
