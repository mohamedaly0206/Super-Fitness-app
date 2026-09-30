import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import '../../storage/secure_storage_service.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == AppHttpHeaders.unauthorizedCode) {
      await SecureStorageService.deleteToken();
    }

    handler.next(err);
  }
}
