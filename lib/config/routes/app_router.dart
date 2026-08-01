import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/core/widgets/app_web_view.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/pages/app_sections_page.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/page/exercise_screen.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/pages/exercise_details_page.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/cubit/workouts_cubit.dart';
import 'package:super_fitness_app/modules/exercise/presentation/workouts/pages/workouts_page.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/pages/food_details_page.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/page/food_recommendation_page.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/profile/data/models/requests/web_view_args.dart';

abstract class Routes {
  static const String splash = '/';
  static const String exercises = '/exercises';
  static const String foodRecommendation = '/food-recommendation';
  static const String homeRoutes = '/home';
  static const String exerciseDetails = '/exercise-details';
  static const String workouts = '/workouts';
  static const String foodDetails = '/foodDetails';
  static const String uiShowcase = '/ui-showcase';
  static const String webView = '/web-view';
}

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.uiShowcase:
          return PageTransitions.fade(const UIShowcasePage());
        case Routes.homeRoutes:
          return PageTransitions.fade(const AppSectionsPage());
        case Routes.workouts:
          return PageTransitions.fade(
            BlocProvider(
              create: (_) => getIt<WorkoutsCubit>(),
              child: const WorkoutsPage(),
            ),
          );
        case Routes.foodRecommendation:
          final args = settings.arguments as String?;
          return PageTransitions.fade(
            FoodRecommendationPage(initialCategoryName: args),
          );
        case Routes.foodDetails:
          final mealId = settings.arguments as String;
          return PageTransitions.fade(FoodDetailsPage(mealId: mealId));
        case Routes.exerciseDetails:
          final exercise = settings.arguments as ExerciseEntity;
          return PageTransitions.fade(ExerciseDetailsPage(exercise: exercise));
        case Routes.exercises:
          final primeMoverMuscleId = settings.arguments as String;
          return PageTransitions.fade(
            ExerciseScreen(primeMoverMuscleId: primeMoverMuscleId),
          );
        case Routes.webView:
          final args = settings.arguments as WebViewArgs;
          return PageTransitions.fade(AppWebView(args: args));
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
