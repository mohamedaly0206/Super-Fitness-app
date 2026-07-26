import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable()
class GetLevelsUseCase {
  final ExerciseRepo _exerciseRepo;

  GetLevelsUseCase(this._exerciseRepo);

  Future<BaseResponse<List<LevelEntity>>> call() async {
    return await _exerciseRepo.getLevels();
  }
}
