import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';

const staticToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmE1OTZjMzdlYTk2NThjZWEyNDgyZDBiIiwiaWF0IjoxNzg1NTUyMzk1fQ.HK4szYFq7UpWWkgD4Geev57lUGo2yC6NLGY1zWEaQnA';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SecureStorageService.saveToken(staticToken);
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
