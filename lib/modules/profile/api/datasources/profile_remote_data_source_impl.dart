import 'package:injectable/injectable.dart';
import '../../../../core/network/model/profile_response/profile_response.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../api_client/profile_api_client.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<ProfileResponseDto> getProfile() async {
    return await _profileApiClient.getProfile();
  }
}