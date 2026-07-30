import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/config/base/base_response.dart';
import 'package:super_fitness_app/core/error/error_handler.dart';
import 'package:super_fitness_app/core/network/mapper/logout_response_mapper.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/logout_entity.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../api_client/profile_api_client.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient profileApiClient;

  ProfileRemoteDataSourceImpl({required this.profileApiClient});

  @override
  Future<BaseResponse<LogoutEntity>> logout() async {
    try {
      final response = await profileApiClient.logout();
      return SuccessBaseResponse<LogoutEntity>(data: response.toDomain());
    } catch (e) {
      return ErrorBaseResponse<LogoutEntity>(failure: ErrorHandler.handle(e));
    }
  }
}
