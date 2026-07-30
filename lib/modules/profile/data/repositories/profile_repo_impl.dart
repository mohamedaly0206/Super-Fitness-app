import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});

  @override
  Future<BaseResponse<LogoutEntity>> logout() async {
    final response = await profileRemoteDataSource.logout();

    switch (response) {
      case SuccessBaseResponse<LogoutEntity>():
        return SuccessBaseResponse<LogoutEntity>(data: response.data);
      case ErrorBaseResponse<LogoutEntity>():
        return ErrorBaseResponse<LogoutEntity>(failure: response.failure);
    }
  }
}
