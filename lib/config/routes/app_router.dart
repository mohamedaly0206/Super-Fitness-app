import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/config/routes/page_transitions.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/not_found_screen.dart';
import 'package:super_fitness_app/core/widgets/ui_showcase_page.dart';
import 'package:super_fitness_app/modules/app_sections/presentation/pages/app_sections_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/forget_password/page/forget_password_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/view_model/cubit/login_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/login/views/login_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/page/onboarding_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/main_register_view_controller.dart';
import 'package:super_fitness_app/modules/exercise/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise/page/exercise_screen.dart';
import 'package:super_fitness_app/modules/exercise/presentation/exercise_details/pages/exercise_details_page.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/pages/food_details_page.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_recommendation/page/food_recommendation_page.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/page/smart_coach_screen.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
      case Routes.onboarding:
        return PageTransitions.fade(const OnboardingPage());

      case Routes.login:
        return PageTransitions.fade(
          BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );

      case Routes.register:
        return PageTransitions.fade(MainRegisterViewController());

      case Routes.forgetPassword:
        return PageTransitions.fade(
          BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordPage(),
          ),
        );

      case Routes.appSections:
        return PageTransitions.fade(const AppSectionsPage());

      case Routes.exercises:
        final primeMoverMuscleId = settings.arguments as String;
        return PageTransitions.slide(
          ExerciseScreen(primeMoverMuscleId: primeMoverMuscleId),
          settings: settings,
        );

      case Routes.exerciseDetails:
        final exercise = settings.arguments as ExerciseEntity;
        return PageTransitions.slide(
          ExerciseDetailsPage(exercise: exercise),
          settings: settings,
        );

      case Routes.foodRecommendation:
        final initialCategoryName = settings.arguments as String?;
        return PageTransitions.slide(
          FoodRecommendationPage(initialCategoryName: initialCategoryName),
          settings: settings,
        );

      case Routes.foodDetails:
        final mealId = settings.arguments as String;
        return PageTransitions.slide(
          FoodDetailsPage(mealId: mealId),
          settings: settings,
        );
      case Routes.smartCotchChat:
        return PageTransitions.fade(const SmartCoachScreen());

      // case Routes.test:
      //   return PageTransitions.fade(const TestScreen());

      case Routes.uiShowcase:
        return PageTransitions.fade(const UIShowcasePage());

      default:
        return PageTransitions.fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }
}
