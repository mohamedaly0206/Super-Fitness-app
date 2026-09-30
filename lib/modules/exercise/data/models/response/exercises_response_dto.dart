import 'package:json_annotation/json_annotation.dart';

import 'exercise_dto.dart';

part 'exercises_response_dto.g.dart';

@JsonSerializable()
class ExercisesResponseDto {
  String? message;

  int? totalExercises;
  int? totalPages;
  int? currentPage;

  List<ExerciseDto>? exercises;

  ExercisesResponseDto({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExercisesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesResponseDtoToJson(this);
}
