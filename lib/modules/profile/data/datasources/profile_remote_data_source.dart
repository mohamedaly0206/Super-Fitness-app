import '../../../../core/network/model/profile_response/profile_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseDto> getProfile();
}