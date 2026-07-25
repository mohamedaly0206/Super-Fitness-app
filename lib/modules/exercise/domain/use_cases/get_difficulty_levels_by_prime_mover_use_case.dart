import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import '../entities/difficulty_levels_response_entity.dart';
import '../repositories/exercise_repo.dart';

@injectable
class GetDifficultyLevelsByPrimeMoverUseCase {
  final ExerciseRepo _repo;

  const GetDifficultyLevelsByPrimeMoverUseCase(this._repo);

  Future<BaseResponse<DifficultyLevelsResponseEntity>> call(
    String primeMoverMuscleId,
  ) {
    return _repo.getDifficultyLevelsByPrimeMover(primeMoverMuscleId);
  }
}
