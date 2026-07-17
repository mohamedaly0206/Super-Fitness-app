import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/feature/forget_password/api/api_client/forget_password_api_client.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio get dio => DioHelper.dio;

  @singleton
  ForgetPasswordApiClient authApi(Dio dio) => ForgetPasswordApiClient(dio);
}
