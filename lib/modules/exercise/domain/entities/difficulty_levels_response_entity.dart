import 'package:equatable/equatable.dart';

import 'difficulty_level_entity.dart';

class DifficultyLevelsResponseEntity extends Equatable {
  final String message;
  final int totalLevels;
  final List<DifficultyLevelEntity> difficultyLevels;

  const DifficultyLevelsResponseEntity({
    required this.message,
    required this.totalLevels,
    required this.difficultyLevels,
  });

  @override
  List<Object?> get props => [message, totalLevels, difficultyLevels];
}
