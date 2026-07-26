import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable()
class GetRandomMusclesUseCase {
  final ExerciseRepo _exerciseRepo;

  GetRandomMusclesUseCase(this._exerciseRepo);

  Future<BaseResponse<List<MuscleEntity>>> call() async {
    return await _exerciseRepo.getRandomMuscles();
  }
}
