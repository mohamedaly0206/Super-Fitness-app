import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/features/auth/presentation/cubit/register_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/pages/login_placeholder_page.dart';
import 'package:super_fitness_app/features/auth/presentation/pages/register_continuation_placeholder_page.dart';
import 'package:super_fitness_app/features/auth/presentation/pages/register_page.dart';

abstract class Routes {
  static const String splash = '/';
  static const String uiShowcase = '/ui-showcase';
  static const String register = '/register';
  // TEMPORARY — remove once the real Register-continuation/Login features
  // replace them.
  static const String registerContinuation = '/register-continuation';
  static const String loginPlaceholder = '/login-placeholder';
}

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.uiShowcase:
          return PageTransitions.fade(const UIShowcasePage());
        case Routes.register:
          return PageTransitions.fade(
            BlocProvider.value(
              value: getIt<RegisterCubit>(),
              child: const RegisterPage(),
            ),
          );
        case Routes.registerContinuation:
          return PageTransitions.fade(
            BlocProvider.value(
              value: getIt<RegisterCubit>(),
              child: const RegisterContinuationPlaceholderPage(),
            ),
          );
        case Routes.loginPlaceholder:
          return PageTransitions.fade(const LoginPlaceholderPage());
        default:
          return PageTransitions.fade(
            NotFoundScreen(route: settings.name ?? ''),
          );
      }
    } catch (_) {
      return PageTransitions.fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }
}
