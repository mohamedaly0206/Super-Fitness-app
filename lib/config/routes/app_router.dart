import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/page/forget_password_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/page/onboarding_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/main_register_view_controller.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/cubit/login_cubit.dart';
import '../../modules/auth/presentation/login/views/login_view.dart';

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
          return PageTransitions.fade(const OnboardingPage());
        case Routes.register:
          return PageTransitions.fade(MainRegisterViewController());

        case Routes.login:
          return PageTransitions.fade(
            BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginView(),
            ),
          );
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