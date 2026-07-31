import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

import '../cubit/smart_coach_cubit.dart';
import '../cubit/smart_coach_intent.dart';
import '../cubit/smart_coach_state.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    context.read<SmartCoachCubit>().doIntent(SendMessageIntent(text));

    _controller.clear();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartCoachCubit, SmartCoachState>(
      buildWhen: (previous, current) => previous.isTyping != current.isTyping,
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: !state.isTyping,
                    minLines: 1,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    cursorColor: AppColors.primary,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    onFieldSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: 'Ask your Smart Coach...',
                      hintStyle: getMediumStyle(
                        context: context,
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.glassFill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: .06),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(
                          color: AppColors.chatGlassPrimaryFill,
                          width: 1.2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  scale: state.isTyping ? .92 : 1,
                  child: InkWell(
                    onTap: state.isTyping ? null : _send,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: state.isTyping
                            ? AppColors.chatGlassFill
                            : AppColors.chatGlassPrimaryFill,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
