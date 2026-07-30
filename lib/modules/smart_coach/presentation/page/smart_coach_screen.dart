import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_intent.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_state.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/page/welcome_view.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/chat_app_bar.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/history_drawer.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/message_input.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/message_list.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/widgets/welcome_appbar.dart';

class SmartCoachScreen extends StatelessWidget {
  const SmartCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SmartCoachCubit>()..doIntent(const LoadConversationsIntent()),
      child: const _SmartCoachView(),
    );
  }
}

class _SmartCoachView extends StatefulWidget {
  const _SmartCoachView();

  @override
  State<_SmartCoachView> createState() => _SmartCoachViewState();
}

class _SmartCoachViewState extends State<_SmartCoachView> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      final position = _scrollController.position.maxScrollExtent;
      if (animated) {
        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(position);
      }
    });
  }

  double _scrollOffset = 0;
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      if ((offset - _scrollOffset).abs() > 2) {
        setState(() {
          _scrollOffset = offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmartCoachCubit, SmartCoachState>(
      listenWhen: (previous, current) {
        final oldLength = previous.currentSession?.messages.length ?? 0;
        final newLength = current.currentSession?.messages.length ?? 0;
        return oldLength != newLength || previous.isTyping != current.isTyping;
      },
      listener: (_, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
        return CustomScaffold(
          background: Backgrounds.chat,
          extendBehindAppBar: true,
          appBar: state.currentSession == null
              ? const WelcomeAppBar()
              : ChatAppBar(
                  conversation: state.currentSession!.conversation,
                  scrollOffset: _scrollOffset,
                ),
          endDrawer: const ChatHistoryDrawer(),
          body: state.currentSession == null
              ? const WelcomeView()
              : Column(
                  children: [
                    Expanded(
                      child: MessageList(
                        controller: _scrollController,
                        messages: state.currentSession!.messages,
                        isTyping: state.isTyping,
                      ),
                    ),
                    const MessageInput(),
                  ],
                ),
        );
      },
    );
  }
}
