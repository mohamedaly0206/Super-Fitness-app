import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/dummy_login_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/page/forget_password_screen.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/page/onboarding_screen.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/main_register_view_controller.dart';

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
          return PageTransitions.fade(OnboardingScreen());
        case Routes.register:
          return PageTransitions.fade(MainRegisterViewController());

        case Routes.loginPlaceholder:
          return PageTransitions.fade(const DummyLoginView());
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
