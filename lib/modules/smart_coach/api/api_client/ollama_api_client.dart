import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:super_fitness_app/config/ai_config.dart';
import 'package:super_fitness_app/modules/smart_coach/data/models/ollama_chat_response.dart';

import '../../domain/entities/chat_message.dart';

class OllamaApiClient {
  final Dio _dio;

  OllamaApiClient(this._dio);

  List<ChatMessage> _withSystemPrompt(List<ChatMessage> messages) {
    return messages;
  }

  Stream<String> sendChatMessageStream({
    required List<ChatMessage> messages,
    String model = AiConfig.model,
  }) async* {
    try {
      final response = await _dio.post(
        '/api/chat',
        data: {
          'model': model,
          'messages': _withSystemPrompt(
            messages,
          ).map((m) => m.toMap()).toList(),
          'stream': true,
        },
        options: Options(responseType: ResponseType.stream),
      );

      final stream = response.data as ResponseBody;
      String buffer = '';

      await for (final chunk in stream.stream) {
        buffer += utf8.decode(chunk);
        final lines = buffer.split('\n');
        buffer = lines.removeLast();

        for (final line in lines) {
          if (line.trim().isEmpty) continue;

          try {
            final data = jsonDecode(line) as Map<String, dynamic>;
            final ollamaResponse = OllamaChatResponse.fromJson(data);

            if (ollamaResponse.message?.content != null) {
              yield ollamaResponse.message!.content;
            }

            if (ollamaResponse.done) return;
          } catch (e) {
            log('Failed to parse Ollama chunk: $e');
          }
        }
      }

      if (buffer.trim().isNotEmpty) {
        try {
          final data = jsonDecode(buffer) as Map<String, dynamic>;
          final ollamaResponse = OllamaChatResponse.fromJson(data);

          if (ollamaResponse.message?.content != null) {
            yield ollamaResponse.message!.content;
          }
        } catch (e) {
          log('Failed to parse final Ollama chunk: $e');
        }
      }
    } on DioException catch (e) {
      throw Exception('Ollama streaming error: ${e.message}');
    }
  }

  Future<String> sendChatMessage({
    required List<ChatMessage> messages,
    String model = AiConfig.model,
  }) async {
    try {
      final response = await _dio.post(
        '/api/chat',
        data: {
          'model': model,
          'messages': _withSystemPrompt(
            messages,
          ).map((m) => m.toMap()).toList(),
          'stream': false,
        },
        options: Options(
          responseType: ResponseType.json,
          receiveTimeout: AiConfig.chatTimeout,
        ),
      );

      final ollamaResponse = OllamaChatResponse.fromJson(response.data);
      return ollamaResponse.message?.content ?? '';
    } on DioException catch (e) {
      throw Exception('Ollama chat error: ${e.message}');
    }
  }

  Future<bool> isServerRunning() async {
    try {
      await _dio.get(
        '/',
        options: Options(
          responseType: ResponseType.json,
          receiveTimeout: const Duration(seconds: 3),
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String> generateChatTitle({
    required String firstMessage,
    String model = AiConfig.model,
  }) async {
    try {
      final response = await _dio.post(
        '/api/chat',
        data: {
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content':
                  'Generate a short conversation title (max 5 words) based on the user message. Reply with ONLY the title.',
            },
            {'role': 'user', 'content': firstMessage},
          ],
          'stream': false,
        },
        options: Options(
          responseType: ResponseType.json,
          receiveTimeout: AiConfig.titleTimeout,
        ),
      );

      final ollamaResponse = OllamaChatResponse.fromJson(response.data);

      return ollamaResponse.message?.content.trim() ??
          AiConfig.defaultConversationTitle;
    } catch (_) {
      return AiConfig.defaultConversationTitle;
    }
  }

  void close() {
    _dio.close(force: true);
  }
}
