import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'interceptors/auth_interceptor.dart';

class DioHelper {
  static late Dio dio;
  static late Dio mealsDio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppDurations.apiTimeout,
        receiveTimeout: AppDurations.apiTimeout,
        responseType: ResponseType.json,
        headers: {AppHttpHeaders.contentType: AppHttpHeaders.jsonContentType},
      ),
    );

    dio.interceptors
      ..add(AuthInterceptor())
      ..add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );

    mealsDio = Dio(
      BaseOptions(
        baseUrl: AppConfig.mealsBaseUrl,
        connectTimeout: AppDurations.apiTimeout,
        receiveTimeout: AppDurations.apiTimeout,
        responseType: ResponseType.json,
      ),
    );

    mealsDio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }
}
