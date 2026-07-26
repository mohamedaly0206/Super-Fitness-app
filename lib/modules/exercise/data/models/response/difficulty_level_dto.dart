import 'package:json_annotation/json_annotation.dart';

part 'difficulty_level_dto.g.dart';

@JsonSerializable()
class DifficultyLevelDto {
  final String id;
  final String name;

  const DifficultyLevelDto({required this.id, required this.name});

  factory DifficultyLevelDto.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyLevelDtoToJson(this);
}
