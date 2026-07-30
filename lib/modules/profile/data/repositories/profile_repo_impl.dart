import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<UserEntity> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    return response.user!.toDomain();
  }
}