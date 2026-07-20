import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable()
class GetExercisesByMuscleAndDifficultyUseCase {
  final ExerciseRepo _exerciseRepo;

  GetExercisesByMuscleAndDifficultyUseCase(this._exerciseRepo);

  Future<BaseResponse<List<ExerciseEntity>>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    return await _exerciseRepo.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
