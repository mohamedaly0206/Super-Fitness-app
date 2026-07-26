import 'package:json_annotation/json_annotation.dart';

import 'difficulty_level_dto.dart';

part 'difficulty_levels_response_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsResponseDto {
  final String message;

  final int totalLevels;

  @JsonKey(name: 'difficulty_levels')
  final List<DifficultyLevelDto> difficultyLevels;

  const DifficultyLevelsResponseDto({
    required this.message,
    required this.totalLevels,
    required this.difficultyLevels,
  });

  factory DifficultyLevelsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelsResponseDtoToJson(this);
}
