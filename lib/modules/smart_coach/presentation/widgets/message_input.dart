import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';

import '../cubit/smart_coach_cubit.dart';
import '../cubit/smart_coach_event.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    context.read<SmartCoachCubit>().doEvent(SendMessageEvent(text));

    _controller.clear();

    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final bool canSend = _hasText && !context.select(
      (SmartCoachCubit c) => c.state.isTyping,
    );
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
                onChanged: (_) => _onTextChanged(),
                enabled: !context.select(
                  (SmartCoachCubit c) => c.state.isTyping,
                ),
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
              scale: canSend ? 1 : .92,
              child: InkWell(
                onTap: canSend ? _send : null,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: canSend
                        ? AppColors.chatGlassPrimaryFill
                        : AppColors.chatGlassFill,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: canSend
                        ? Colors.white
                        : Colors.white.withValues(alpha: .4),
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
