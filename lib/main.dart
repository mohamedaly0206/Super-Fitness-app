import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  DioHelper.init();
  configureDependencies();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppKeys.enLocale),
        Locale(AppKeys.arLocale),
      ],
      path: AppKeys.translationPath,
      child: const FitnessApp(),
    ),
  );
}
