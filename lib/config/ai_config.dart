class AiConfig {
  const AiConfig._();

  static const String model = 'gemma3:1b';

  static const bool stream = true;

  static const Duration chatTimeout = Duration(minutes: 5);

  static const Duration titleTimeout = Duration(seconds: 30);

  static const int maxConversationTokens = 10000;

  static const String defaultConversationTitle = 'New Conversation';
}
