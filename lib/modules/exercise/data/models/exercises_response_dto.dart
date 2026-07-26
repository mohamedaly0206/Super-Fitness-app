import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/exercise/data/models/exercise_dto.dart';

part 'exercises_response_dto.g.dart';

@JsonSerializable()
class ExercisesResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "totalExercises")
  int? totalExercises;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "currentPage")
  int? currentPage;

  @JsonKey(name: "exercises")
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
