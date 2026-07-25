import 'package:json_annotation/json_annotation.dart';

import 'exercise_dto.dart';

part 'exercises_response_dto.g.dart';

@JsonSerializable()
class ExercisesResponseDto {
  final String message;

  final int totalExercises;
  final int totalPages;
  final int currentPage;

  final List<ExerciseDto> exercises;

  const ExercisesResponseDto({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });

  factory ExercisesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesResponseDtoToJson(this);
}
