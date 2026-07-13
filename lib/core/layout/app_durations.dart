abstract class AppDurations {
  AppDurations._();

  //  TRANSITIONS
  static const Duration fadeTransition = Duration(milliseconds: 300);
  static const Duration slideTransition = Duration(milliseconds: 350);
  static const Duration searchTransition = Duration(milliseconds: 450);
  static const Duration searchReverseTransition = Duration(milliseconds: 300);

  //  API
  static const Duration apiTimeout = Duration(seconds: 30);

  //  UI
  static const Duration shimmerPeriod = Duration(milliseconds: 1100);
  static const Duration snackBarDisplay = Duration(seconds: 3);
  static const Duration navBarAnimation = Duration(milliseconds: 300);

  //  APP
  static const Duration exitBackPress = Duration(seconds: 2);
}
