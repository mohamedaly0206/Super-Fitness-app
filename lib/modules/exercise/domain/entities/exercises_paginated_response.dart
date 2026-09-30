import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';

class ExercisesPaginatedResponse {
  final List<ExerciseEntity> exercises;
  final int currentPage;
  final int totalPages;

  const ExercisesPaginatedResponse({
    required this.exercises,
    required this.currentPage,
    required this.totalPages,
  });
}
