import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/page/exercise_screen.dart';

abstract class Routes {
  static const String splash = '/';
  static const String exercises = '/exercises';
}

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.exercises:
          return PageTransitions.fade(
            ExerciseScreen(primeMoverMuscleId: '69d982ef85f6bfa972bf2248'),
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
