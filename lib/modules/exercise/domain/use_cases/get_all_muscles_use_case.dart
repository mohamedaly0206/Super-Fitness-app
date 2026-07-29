import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable()
class GetAllMusclesUseCase {
  final ExerciseRepo _exerciseRepo;

  GetAllMusclesUseCase(this._exerciseRepo);

  Future<BaseResponse<List<MuscleGroupEntity>>> call() async {
    return await _exerciseRepo.getAllMuscles();
  }
}
