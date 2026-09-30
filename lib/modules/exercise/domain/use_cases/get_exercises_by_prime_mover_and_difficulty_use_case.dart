import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import '../entities/exercises_response_entity.dart';
import '../repositories/exercise_repo.dart';

@injectable
class GetExercisesByPrimeMoverAndDifficultyUseCase {
  final ExerciseRepo _repo;

  const GetExercisesByPrimeMoverAndDifficultyUseCase(this._repo);

  Future<BaseResponse<ExercisesResponseEntity>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _repo.getExercisesByPrimeMoverAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
