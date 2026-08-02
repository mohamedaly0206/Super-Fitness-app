import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/utils/app_validator.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_appbar.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/profile/domain/entities/edit_profile_data.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_state.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/widgets/editable_selection.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity userData;

  const EditProfilePage({super.key, required this.userData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
      text: widget.userData.firstName,
    );
    lastNameController = TextEditingController(text: widget.userData.lastName);
    emailController = TextEditingController(text: widget.userData.email);
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      appBar: CustomAppBar(title: context.editProfile, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: SingleChildScrollView(
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if ((state.editProfileState.data != null &&
                      state.editProfileState.isLoading == false) ||
                  (state.uploadProfileImageState.isLoading == false &&
                      state.uploadProfileImageState.data != null)) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                CustomSnackBar.success(
                  context,
                  context.profileUpdatedSuccessfully,
                );
              } else if (state.editProfileState.errorMessage != null ||
                  state.uploadProfileImageState.errorMessage != null) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                CustomSnackBar.error(
                  context,
                  state.editProfileState.errorMessage ??
                      state.uploadProfileImageState.errorMessage ??
                      '',
                );
              }
            },
            builder: (context, state) {
              final profileCubit = context.read<EditProfileCubit>();
              final levelValue =
                  EditProfileData.activityLevels[state.activityLevel];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppSizedBox(height: AppSize.s20),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundImage: state.imageFile != null
                            ? FileImage(state.imageFile!)
                            : CachedNetworkImageProvider(
                                widget.userData.photo ?? '',
                              ),
                        backgroundColor: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () =>
                            profileCubit.doEvent(PickProfileImageEvent()),
                        child: SizedBox(
                          child: SvgPicture.asset(AppSvg.editIcon),
                        ),
                      ),
                    ],
                  ),
                  const AppSizedBox(height: 16),
                  Text(
                    '${widget.userData.firstName} ${widget.userData.lastName}',
                    style: getSemiBoldStyle(
                      context: context,
                      fontSize: FontSizeManager.s20,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const AppSizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: firstNameController,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person_outline),
                          validator: AppValidator.name,
                          onChanged: (val) =>
                              profileCubit.doEvent(FirstNameChangedEvent(val)),
                        ),
                        const AppSizedBox(height: AppSize.s12),
                        CustomTextField(
                          controller: lastNameController,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person_outline),
                          validator: AppValidator.name,
                          onChanged: (val) =>
                              profileCubit.doEvent(LastNameChangedEvent(val)),
                        ),
                        const AppSizedBox(height: AppSize.s12),
                        CustomTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.mail_outline),
                          validator: AppValidator.email,
                          onChanged: (val) =>
                              profileCubit.doEvent(EmailChangedEvent(val)),
                        ),
                        const AppSizedBox(height: AppSize.s30),
                        EditableSelection(
                          title: context.yourWeight,
                          selectionInfo:
                              '${state.weight ?? widget.userData.weight} ${context.kg}',
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.editWeight,
                            arguments: profileCubit,
                          ),
                        ),
                        const AppSizedBox(height: AppSize.s16),
                        EditableSelection(
                          title: context.yourGoal,
                          selectionInfo:
                              state.goal ?? widget.userData.goal ?? '',
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.editGoal,
                            arguments: profileCubit,
                          ),
                        ),
                        const AppSizedBox(height: AppSize.s16),
                        EditableSelection(
                          title: context.yourActivityLevel,
                          selectionInfo:
                              state.activityLevelValue ?? levelValue ?? '',
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.editActivityLevel,
                            arguments: profileCubit,
                          ),
                        ),
                        AppSizedBox(height: AppSize.s20),
                        state.uploadProfileImageState.isLoading ||
                                state.editProfileState.isLoading
                            ? const ButtonLoadingWidget()
                            : PrimaryButton(
                                text: context.saveChanges,
                                onTap:
                                    state.isUserDataChanged ||
                                        state.isProfileImageChanged
                                    ? () {
                                        if (state.imageFile != null &&
                                            state.isProfileImageChanged) {
                                          profileCubit.doEvent(
                                            UploadProfileImageEvent(),
                                          );
                                        } else if (state.isUserDataChanged) {
                                          profileCubit.doEvent(
                                            SubmitEditProfileEvent(),
                                          );
                                        } else if (state.isUserDataChanged &&
                                            state.isProfileImageChanged) {
                                          profileCubit.doEvent(
                                            UpdateProfileImageAndDataEvent(),
                                          );
                                        }
                                      }
                                    : null,
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
