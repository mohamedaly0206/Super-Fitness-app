import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/modules/smart_coach/data/fitness_data_context.dart';

const staticToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmE1ZTA2ZTBlYTk2NThjZWEyNDgzNTc3IiwiaWF0IjoxNzg0NTQ3MDQwfQ.1a3d3BuT7yDwMBnqGEB74-KZHAnZTkvlC3zLGQY9_2I';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SecureStorageService.saveToken(staticToken);
  DioHelper.init();
  configureDependencies();
  await EasyLocalization.ensureInitialized();

  final fitnessContext = FitnessDataContext();
  await fitnessContext.init();
  AppStrings.fitnessDataContext = await fitnessContext.buildContextSummary();
  fitnessContext.close();

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
