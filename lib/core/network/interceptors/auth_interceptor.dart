import 'package:dio/dio.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import '../../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers[AppHttpHeaders.authorization] =
          '${AppHttpHeaders.bearerPrefix}$token';
    }

    handler.next(options);
  }
}
