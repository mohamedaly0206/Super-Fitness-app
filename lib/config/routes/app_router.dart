import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/cubit/login_cubit.dart';
import '../../modules/auth/presentation/login/views/login_view.dart';
import '../dependency_injection/di.dart';

abstract class Routes {
  static const String splash = '/';
  static const String uiShowcase = '/ui-showcase';
  static const String login = '/login';
}

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.uiShowcase:
          return PageTransitions.fade(const UIShowcasePage());
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