import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/exercise/data/datasources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/level_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/modules/exercise/domain/repositories/exercise_repo.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;

  ExerciseRepoImpl({required this.exerciseRemoteDataSource});

  @override
  Future<BaseResponse<List<LevelEntity>>> getLevels() async {
    final response = await exerciseRemoteDataSource.getLevels();

    switch (response) {
      case SuccessBaseResponse<List<LevelEntity>>():
        return SuccessBaseResponse<List<LevelEntity>>(data: response.data);
      case ErrorBaseResponse<List<LevelEntity>>():
        return ErrorBaseResponse<List<LevelEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles() async {
    final response = await exerciseRemoteDataSource.getRandomMuscles();

    switch (response) {
      case SuccessBaseResponse<List<MuscleEntity>>():
        return SuccessBaseResponse<List<MuscleEntity>>(data: response.data);
      case ErrorBaseResponse<List<MuscleEntity>>():
        return ErrorBaseResponse<List<MuscleEntity>>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    final response = await exerciseRemoteDataSource.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );

    switch (response) {
      case SuccessBaseResponse<List<ExerciseEntity>>():
        return SuccessBaseResponse<List<ExerciseEntity>>(data: response.data);
      case ErrorBaseResponse<List<ExerciseEntity>>():
        return ErrorBaseResponse<List<ExerciseEntity>>(failure: response.failure);
    }
  }
}
