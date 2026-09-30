import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/app_router.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/theme/app_theme.dart';

class FitnessApp extends StatelessWidget {
  final bool hasToken;

  const FitnessApp({super.key, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: hasToken ? Routes.appSections : Routes.onboarding,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: Localizations.override(
            context: context,
            locale: context.locale,
            child: child ?? const SizedBox(),
          ),
        );
      },
    );
  }
}
