import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import '../../domain/entities/conversation.dart';
import '../cubit/smart_coach_cubit.dart';
import '../cubit/smart_coach_intent.dart';
import '../cubit/smart_coach_state.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;

  const ConversationTile({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minTileHeight: 0,
      leading: SvgPicture.asset(AppSvg.arrowLeft),
      title: Text(
        conversation.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: getMediumStyle(
          context: context,
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        context.read<SmartCoachCubit>().doIntent(
          OpenConversationIntent(conversation.id),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    title: const Text('Delete Conversation'),
                    onTap: () {
                      final isCurrent = context
                              .read<SmartCoachCubit>()
                              .state
                              .currentSession
                              ?.conversation
                              .id ==
                          conversation.id;

                      Navigator.pop(context);

                      if (isCurrent && Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }

                      context.read<SmartCoachCubit>().doIntent(
                        DeleteConversationIntent(conversation.id),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
