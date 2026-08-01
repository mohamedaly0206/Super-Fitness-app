import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:super_fitness_app/app.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/network/dio_helper.dart';
import 'package:super_fitness_app/core/resources/app_value.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';

const staticToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmE1YjcxMTVlYTk2NThjZWEyNDgzMWJkIiwiaWF0IjoxNzg1NTk1MzgxfQ.0HXIub7xMFltnkFpCLfSP5KeIqmH5YWb_A6itKeXm0c';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await SecureStorageService.saveToken(staticToken);

  DioHelper.init();

  configureDependencies();

  runApp(
    Phoenix(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: AppKeys.translationPath,
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        child: const FitnessApp(),
      ),
    ),
  );
}
