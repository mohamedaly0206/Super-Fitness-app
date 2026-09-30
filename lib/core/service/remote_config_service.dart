import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  String get googlePassword => _remoteConfig.getString('google_password');

  String get facebookPassword => _remoteConfig.getString('facebook_password');
}