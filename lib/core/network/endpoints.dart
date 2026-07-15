
class AppConfig {
  static const baseUrl = "https://fitness.elevateegy.com/api/v1";
}

abstract class Endpoints {
  static const String auth = '/api/auth';
  static const String profile = '/api/profile';
  static const String onboarding = '/api/onboarding';
  static const String workouts = '/api/workouts';
  static const String exercises = '/api/exercises';
  static const String meals = '/api/meals';
  static const String settings = '/api/settings';
}

abstract class AuthEndPoint {
  static const String signup = '${Endpoints.auth}/signup';
  static const String login = '${Endpoints.auth}/login';
  static const String logout = '${Endpoints.auth}/logout';
  static const String refresh = '${Endpoints.auth}/refresh';
  static const String forgetPassword = '${Endpoints.auth}/forget-password';
  static const String verifyCode = '${Endpoints.auth}/verify-code';
  static const String resetPassword = '${Endpoints.auth}/reset-password';
}

abstract class ProfileEndPoint {
  static const String getProfile = Endpoints.profile;
  static const String updateProfile = '${Endpoints.profile}/update';
  static const String uploadAvatar = '${Endpoints.profile}/upload-avatar';
}

abstract class OnboardingEndPoint {
  static const String submit = '${Endpoints.onboarding}/submit';
  static const String status = '${Endpoints.onboarding}/status';
}

abstract class WorkoutEndPoint {
  static const String workouts = Endpoints.workouts;
  static String workoutById(String id) => '${Endpoints.workouts}/$id';
  static const String trackProgress = '${Endpoints.workouts}/track-progress';
  static const String exercises = Endpoints.exercises;
  static String exerciseById(String id) => '${Endpoints.exercises}/$id';
}

abstract class MealEndPoint {
  static const String meals = Endpoints.meals;
  static String mealById(String id) => '${Endpoints.meals}/$id';
  static const String logMeal = '${Endpoints.meals}/log';
}

abstract class SettingsEndPoint {
  static const String settings = Endpoints.settings;
}
