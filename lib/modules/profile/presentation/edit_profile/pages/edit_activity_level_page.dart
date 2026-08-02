import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
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

class EditActivityLevelPage extends StatelessWidget {
  const EditActivityLevelPage({super.key});

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
            mainAxisSize: MainAxisSize
                .min, // Tells the column to only take up as much space as it needs
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  AuthConstants.yourRegularPhysicalActivityLevel,
                  style: getExtraBoldStyle(
                    context: context,
                    color: theme.colorScheme.onPrimary,
                    fontSize: FontSizeManager.s20,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s16),
              // Removed the Expanded(flex: 2) wrapper
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  return CustomContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: EditProfileData.activityLevels.length,
                          itemBuilder: (context, index) {
                            final activityKey = EditProfileData
                                .activityLevels
                                .keys
                                .elementAt(index);
                            final activityValue =
                                EditProfileData.activityLevels[activityKey]!;
                            return RegisterSelectionCard(
                              title: activityValue,
                              isSelected: state.activityLevel == activityKey,
                              onTap: () {
                                cubit.doEvent(
                                  SelectActivityLevelEvent(
                                    activityKey,
                                    activityValue,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        PrimaryButton(
                          text: AuthConstants.done,
                          onTap: state.activityLevel == null
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
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
