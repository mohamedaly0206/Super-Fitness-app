import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/pages/forget_password_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/pages/login_placeholder_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/pages/register_continuation_placeholder_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/pages/register_page.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.uiShowcase:
          return PageTransitions.fade(const UIShowcasePage());
        case Routes.forgetPassword:
          return PageTransitions.fade(
            BlocProvider(
              create: (_) => getIt<ForgetPasswordCubit>(),
              child: const ForgetPasswordPage(),
            ),
          );
        case Routes.onboarding:
          return PageTransitions.fade(OnboardingPage());
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
