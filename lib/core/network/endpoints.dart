class AppConfig {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1";
  static const String mealsBaseUrl = "https://www.themealdb.com/api/json/v1/1/";
}

abstract class Endpoints {
  static const String auth = 'auth';
  static const String levels = 'levels';
  static const String muscles = 'muscles';
  static const String musclesGroup = 'musclesGroup';
  static const String exercises = 'exercises';
}

abstract class AuthEndPoint {
  static const String signup = '${Endpoints.auth}/signup';
  static const String signin = '${Endpoints.auth}/signin';
  static const String changePassword = '${Endpoints.auth}/change-password';
  static const String uploadPhoto = '${Endpoints.auth}/upload-photo';
  static const String profileData = '${Endpoints.auth}/profile-data';
  static const String logout = '${Endpoints.auth}/logout';
  static const String forgotPassword = '${Endpoints.auth}/forgotPassword';
  static const String verifyResetCode = '${Endpoints.auth}/verifyResetCode';
  static const String resetPassword = '${Endpoints.auth}/resetPassword';
  static const String deleteMe = '${Endpoints.auth}/deleteMe';
  static const String editProfile = '${Endpoints.auth}/editProfile';
}

abstract class LevelsEndPoint {
  static const String levels = Endpoints.levels;
  static const String difficultyByPrimeMover =
      '${Endpoints.levels}/difficulty-levels/by-prime-mover';
}

abstract class MusclesEndPoint {
  static const String muscles = Endpoints.muscles;
  static String muscleGroupById(String id) => '${Endpoints.musclesGroup}/$id';
  static const String random = '${Endpoints.muscles}/random';
  static const String byMuscleGroup =
      '${Endpoints.musclesGroup}/by-muscle-group';
}

abstract class ExercisesEndPoint {
  static const String exercises = Endpoints.exercises;
  static const String byMuscleDifficulty =
      '${Endpoints.exercises}/by-muscle-difficulty';
  static const String random = '${Endpoints.exercises}/random';
}

abstract class MealEndPoint {
  static const String categories = 'categories.php';
  static const String filter = 'filter.php';
  static const String lookup = 'lookup.php';
}
