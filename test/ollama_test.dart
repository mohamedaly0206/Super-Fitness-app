import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/modules/smart_coach/api/api_client/ollama_api_client.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/chat_message.dart';

void main() {
  late OllamaApiClient client;

  setUp(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:11434',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(minutes: 5),
      ),
    );
    client = OllamaApiClient(dio);
  });

  tearDown(() {
    client.close();
  });

  test('health check', () async {
    final running = await client.isServerRunning();
    print('Ollama running: $running');
    expect(running, isTrue);
  });

  test('non-streaming chat', () async {
    final response = await client.sendChatMessage(
      messages: [
        const ChatMessage.system('You are a fitness coach. Be concise.'),
        const ChatMessage.user(
          'What is the best warm-up before lifting weights?',
        ),
      ],
    );
    print('Response: $response');
    expect(response.isNotEmpty, isTrue);
  });

  test('streaming chat', () async {
    final stream = client.sendChatMessageStream(
      messages: [
        const ChatMessage.system('You are a fitness coach. Be concise.'),
        const ChatMessage.user('Give me 3 quick meal ideas for muscle gain.'),
      ],
    );

    final buffer = StringBuffer();
    await for (final token in stream) {
      stdout.write(token);
      buffer.write(token);
    }
    print('\nFull response: ${buffer.toString()}');
    expect(buffer.isNotEmpty, isTrue);
  });

  test('generate chat title', () async {
    final title = await client.generateChatTitle(
      firstMessage: 'Can you suggest a high protein vegetarian meal plan?',
    );
    print('Title: $title');
    expect(title.isNotEmpty, isTrue);
  });

  test('arabic streaming chat', () async {
    final stream = client.sendChatMessageStream(
      messages: [const ChatMessage.user('ايش افضل تمارين لتكبير الصدر؟')],
    );

    final buffer = StringBuffer();
    await for (final token in stream) {
      stdout.write(token);
      buffer.write(token);
    }
    print('\nFull response: ${buffer.toString()}');
    expect(buffer.isNotEmpty, isTrue);
  }, timeout: const Timeout(Duration(minutes: 2)));
}
