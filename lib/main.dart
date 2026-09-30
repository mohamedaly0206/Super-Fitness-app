import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:super_fitness_app/app.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';
import 'package:super_fitness_app/core/service/remote_config_service.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/smart_coach/data/fitness_data_context.dart';

import 'firebase_options.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioHelper.init();
  configureDependencies();
  await getIt<RemoteConfigService>().init();

  final token = await SecureStorageService.getToken();
  final hasToken = token != null && token.isNotEmpty;

  final fitnessContext = FitnessDataContext();
  await fitnessContext.init();
  AppStrings.fitnessDataContext = await fitnessContext.buildContextSummary();
  fitnessContext.close();

  FlutterNativeSplash.remove();
  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: const [
          Locale(AppKeys.enLocale),
          Locale(AppKeys.arLocale),
        ],
        path: AppKeys.translationPath,
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        child: FitnessApp(hasToken: hasToken),
      ),
    ),
  );
}
