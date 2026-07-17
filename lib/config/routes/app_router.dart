import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/feature/forget_password/ui/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/feature/forget_password/ui/page/forget_password_screen.dart';
import 'package:super_fitness_app/feature/forget_password/ui/page/login_screen.dart';

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
        case Routes.login:
          return PageTransitions.fade(const LoginScreen());
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
