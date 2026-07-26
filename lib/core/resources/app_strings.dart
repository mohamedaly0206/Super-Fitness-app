abstract class AppStrings {
  AppStrings._();

  //  GENERAL
  static const String retry = 'Retry';
  static const String oops = 'Oops!';
  static const String goHome = 'Go Home';
  static const String routeNotFound = 'Route not found';
  static const String youTubeVideoIdRegex =
      r'(?:youtu\.be\/|youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})';
  static const String unableToLoadVideo =
      'Unable to play video, please try again';
  //  NAVIGATION
  static const String home = 'Home';
  static const String workout = 'Workout';
  static const String chat = 'Chat';
  static const String profile = 'Profile';

  //  EXIT
  static const String pressBackAgainToExit = 'Press back again to exit';

  //  SHOWCASE
  static const String uiShowcase = 'UI Showcase';
  static const String foodRecommendation = 'Food Recommendation';

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
}

abstract class AppHttpHeaders {
  AppHttpHeaders._();

  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String jsonContentType = 'application/json';
  static const String bearerPrefix = 'Bearer ';
  static const int unauthorizedCode = 401;
}
