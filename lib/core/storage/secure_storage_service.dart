import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: AppKeys.tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: AppKeys.tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: AppKeys.tokenKey);
    await _storage.delete(key: AppKeys.driverIdKey);
    await _storage.delete(key: AppKeys.currentOrderIdKey);
  }
}
