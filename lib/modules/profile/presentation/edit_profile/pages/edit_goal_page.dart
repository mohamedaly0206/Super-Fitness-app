import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_selection_card.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/edit_profile_data.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_state.dart';

class EditGoalPage extends StatelessWidget {
  const EditGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<EditProfileCubit>();

    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Hugs content size to allow exact centering
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthConstants.whatIsYourGoal,
                      style: getExtraBoldStyle(
                        context: context,
                        color: theme.colorScheme.onPrimary,
                        fontSize: FontSizeManager.s20,
                      ),
                    ),
                    Text(
                      AuthConstants.thisHelpsUsCreateYourPersonalizedPlan,
                      style: getMediumStyle(
                        context: context,
                        color: theme.colorScheme.onPrimary,
                        fontSize: FontSizeManager.s18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s16),
              // Removed Expanded flex: 3
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  return CustomContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: EditProfileData.goals.length,
                          itemBuilder: (context, index) {
                            final goal = EditProfileData.goals[index];
                            return RegisterSelectionCard(
                              title: goal,
                              isSelected: state.goal == goal,
                              onTap: () {
                                cubit.doEvent(SelectGoalEvent(goal));
                              },
                            );
                          },
                        ),
                        PrimaryButton(
                          text: AuthConstants.next,
                          onTap: state.goal == null
                              ? null
                              : () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
