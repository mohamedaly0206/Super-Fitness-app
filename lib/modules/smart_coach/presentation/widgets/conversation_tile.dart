import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import '../../domain/entities/conversation.dart';
import '../cubit/smart_coach_cubit.dart';
import '../cubit/smart_coach_event.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;

  const ConversationTile({super.key, required this.conversation});

  void _confirmDelete(BuildContext context) {
    final cubit = context.read<SmartCoachCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.glassFill,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.error,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Delete Conversation?',
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  '"${conversation.title}" will be permanently deleted. '
                  'This can\'t be undone.',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.glassFill,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: getMediumStyle(
                            context: context,
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          final isCurrent =
                              cubit.state.currentSession?.conversation.id ==
                              conversation.id;

                          Navigator.pop(sheetContext); // close confirm sheet
                          Navigator.pop(context); // close conversations list

                          if (isCurrent && Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }

                          cubit.doEvent(
                            DeleteConversationEvent(conversation.id),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
        context.read<SmartCoachCubit>().doEvent(
          OpenConversationEvent(conversation.id),
        );
      },
      onLongPress: () => _confirmDelete(context),
    );
  }
}
