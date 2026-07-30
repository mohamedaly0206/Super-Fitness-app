import 'package:super_fitness_app/modules/smart_coach/domain/entities/message.dart';

class SendSmartCoachMessageParams {
  final String conversationId;

  final List<Message> previousMessages;

  final String userMessage;

  const SendSmartCoachMessageParams({
    required this.conversationId,
    required this.previousMessages,
    required this.userMessage,
  });
}
