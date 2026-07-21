import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercises_paginated_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable()
class GetExercisesByMuscleAndDifficultyUseCase {
  final ExerciseRepo _exerciseRepo;

  GetExercisesByMuscleAndDifficultyUseCase(this._exerciseRepo);

  Future<BaseResponse<ExercisesPaginatedResponse>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    required int page,
  }) async {
    return await _exerciseRepo.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
  }
}
