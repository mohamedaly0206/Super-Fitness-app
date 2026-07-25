import 'package:super_fitness_app/modules/exercise/data/models/response/exercises_response_dto.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_response_entity.dart';
import 'exercise_mapper.dart';

extension ExercisesResponseMapper on ExercisesResponseDto {
  ExercisesResponseEntity toDomain() {
    return ExercisesResponseEntity(
      message: message,
      totalExercises: totalExercises,
      totalPages: totalPages,
      currentPage: currentPage,
      exercises: exercises.map((e) => e.toDomain()).toList(),
    );
  }
}
