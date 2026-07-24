import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/pages/app_sections_page.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/pages/exercise_details_page.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/pages/workouts_page.dart';

abstract class Routes {
  static const String splash = '/';
  static const String uiShowcase = '/ui-showcase';
  static const String homeRoutes = '/home';
  static const String exerciseDetails = '/exercise-details';
  static const String workouts = '/workouts';
}

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.homeRoutes:
          return PageTransitions.fade(const AppSectionsPage());

        case Routes.exerciseDetails:
          final exercise = settings.arguments as ExerciseEntity;
          return PageTransitions.slide(
            ExerciseDetailsPage(exercise: exercise),
          );

        case Routes.workouts:
          return PageTransitions.slide(
            BlocProvider(
              create: (context) => getIt<WorkoutsCubit>(),
              child: const WorkoutsPage(),
            ),
            settings: settings,
          );

        case Routes.uiShowcase:
          return PageTransitions.fade(const UIShowcasePage());

        default:
          return PageTransitions.fade(
            NotFoundScreen(route: settings.name ?? ''),
          );
      }
    } catch (e) {
      return PageTransitions.fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }
}
