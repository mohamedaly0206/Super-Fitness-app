import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
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
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: AppKeys.userIdKey, value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: AppKeys.userIdKey);
  }

  static Future<void> deleteUserId() async {
    await _storage.delete(key: AppKeys.userIdKey);
  }

  static Future<void> saveUserName(String userName) async {
    await _storage.write(key: AppKeys.userNameKey, value: userName);
  }

  static Future<String?> getUserName() async {
    return await _storage.read(key: AppKeys.userNameKey);
  }

  static Future<void> deleteUserName() async {
    await _storage.delete(key: AppKeys.userNameKey);
  }

  static Future<void> saveProfileImage(String profileImage) async {
    await _storage.write(key: AppKeys.profileImageKey, value: profileImage);
  }

  static Future<String?> getProfileImage() async {
    return await _storage.read(key: AppKeys.profileImageKey);
  }

  static Future<void> deleteProfileImage() async {
    await _storage.delete(key: AppKeys.profileImageKey);
  }

  static Future<void> saveUser(UserEntity user) async {
    final name = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    if (name.isNotEmpty) {
      await saveUserName(name);
    }
    if (user.photo != null && user.photo!.isNotEmpty) {
      await saveProfileImage(user.photo!);
    }
  }
}
