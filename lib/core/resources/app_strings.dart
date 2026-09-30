import 'package:easy_localization/easy_localization.dart';

abstract class AppStrings {
  AppStrings._();

  static String get retry => "general.retry".tr();
  static String get oops => "general.oops".tr();
  static String get goHome => "general.go_home".tr();
  static String get routeNotFound => "general.route_not_found".tr();
  static String get unableToLoadVideo => "general.unable_to_load_video".tr();

  static const String youTubeVideoIdRegex =
      r'(?:youtu\.be\/|youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})';

  static String get home => "navigation.home".tr();
  static String get workout => "navigation.workout".tr();
  static String get chat => "navigation.chat".tr();
  static String get profile => "navigation.profile".tr();

  //  SMART COACH
  static const String _smartCoachPromptEn =
      'You are SmartCoach, an expert AI fitness coach inside a fitness app. '
      'You help users with workout plans, exercise guidance, nutrition advice, '
      'meal planning, and general fitness knowledge. '
      'Be concise, motivational, and practical. '
      'If a question is unrelated to fitness, politely redirect to fitness topics. '
      'Use simple language and avoid jargon unless the user asks for it. '
      'Always respond in English.';

  static const String _smartCoachPromptAr =
      'أنت SmartCoach، مدرب لياقة بدنية خبير داخل تطبيق لياقة بدنية. '
      'تساعد المستخدمين بخطط التمرين، نصائح التغذية، وتخطيط الوجبات. '
      'كن مختصاً ومحفزاً وعملياً. '
      'إذا كان السؤال غير متعلق باللياقة، أعد توجيه المستخدم بلطف. '
      'استخدم لغة بسيطة وتجنب المصطلحات التقنية إلا إذا طلب المستخدم ذلك. '
      'أجب دائماً بالعربية.';

  static String fitnessDataContext = '';

  static String smartCoachSystemPromptFor(String languageCode) {
    final base = languageCode == 'ar'
        ? _smartCoachPromptAr
        : _smartCoachPromptEn;
    if (fitnessDataContext.isEmpty) return base;
    return '$base\n\n'
        'You have access to the following fitness data from the app:\n\n'
        '$fitnessDataContext\n'
        'Use this data when answering questions about exercises, meals, or nutrition. '
        'Reference specific items from this data when relevant.';
  }

  static String get editProfile => "profile.edit_profile".tr();
  static String get changeProfile => "profile.change_password".tr();
  static String get security => "profile.security".tr();
  static String get privacyPolicy => "profile.privacy_policy".tr();
  static String get help => "profile.help".tr();
  static String get logout => "profile.logout".tr();
  static String get selectLanguage => "profile.select_language".tr();

  static String get pressBackAgainToExit =>
      "general.press_back_again_to_exit".tr();

  static String get uiShowcase => "general.ui_showcase".tr();
  static String get foodRecommendation => "general.food_recommendation".tr();
}

abstract class AppHttpHeaders {
  AppHttpHeaders._();

  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String jsonContentType = 'application/json';
  static const String bearerPrefix = 'Bearer ';
  static const int unauthorizedCode = 401;
}
