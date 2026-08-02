import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import '../cubit/smart_coach_cubit.dart';
import '../cubit/smart_coach_event.dart';
import '../cubit/smart_coach_state.dart';
import 'conversation_tile.dart';

class ChatHistoryDrawer extends StatelessWidget {
  const ChatHistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(213, 36, 36, 36),
      shadowColor: AppColors.grey2,
      child: SafeArea(
        child: BlocBuilder<SmartCoachCubit, SmartCoachState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: AppSize.s15),
                        child: Text(
                          "Previous conversations",
                          style: getSemiBoldStyle(
                            context: context,
                            color: AppColors.textPrimary,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      AppSizedBox(height: AppSize.s15),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(
                            right: AppSize.s15,
                            left: AppSize.s15,
                          ),
                          separatorBuilder: (context, index) =>
                              Divider(color: AppColors.glassBorder),
                          itemCount: state.conversations.length,
                          itemBuilder: (_, index) {
                            return ConversationTile(
                              conversation: state.conversations[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: FloatingActionButton.extended(
                      backgroundColor: AppColors.primary,
                      elevation: 8,
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<SmartCoachCubit>().doEvent(
                          const CreateNewConversationEvent(),
                        );
                      },
                      icon: const Icon(Icons.edit_note_rounded),
                      label: const Text("New Chat"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
