import 'package:easy_localization/easy_localization.dart';

abstract class AppStrings {
  AppStrings._();

  //  GENERAL
  static const String retry = 'Retry';
  static const String oops = 'Oops!';
  static const String goHome = 'Go Home';
  static const String routeNotFound = 'Route not found';
  static String get ingredients => "meals.Ingredients".tr();

  //  NAVIGATION
  static const String home = 'Home';
  static const String workout = 'Workout';
  static const String chat = 'Chat';
  static const String profile = 'Profile';

  //  EXIT
  static const String pressBackAgainToExit = 'Press back again to exit';

  //  SHOWCASE
  static const String uiShowcase = 'UI Showcase';
}

abstract class AppHttpHeaders {
  AppHttpHeaders._();

  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String jsonContentType = 'application/json';
  static const String bearerPrefix = 'Bearer ';
  static const int unauthorizedCode = 401;
}
