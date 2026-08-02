import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/localization_constants/error_massage_constants.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/utils/app_validator.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/profile/presentation/change_password/cubit/change_password_cubit.dart';
import 'package:super_fitness_app/modules/profile/presentation/change_password/cubit/change_password_event.dart';
import 'package:super_fitness_app/modules/profile/presentation/change_password/cubit/change_password_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onDone(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordCubit>().doEvent(
      SubmitChangePasswordEvent(
        password: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      ),
    );
  }

  Widget _lockIcon() {
    return Image.asset(
      AppPng.lock,
      width: AppSize.svgIconSize,
      height: AppSize.svgIconSize,
      color: AppColors.iconInactive,
      colorBlendMode: BlendMode.srcIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.forgetPassword,
      body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (previous, current) =>
            previous.changePasswordState != current.changePasswordState,
        listener: (context, state) {
          if (state.changePasswordState.data == true) {
            CustomSnackBar.success(
              context,
              ErrorConstants.changePasswordSuccessfully,
            );
            Navigator.pop(context);
          } else if (state.changePasswordState.errorMessage != null) {
            CustomSnackBar.error(
              context,
              state.changePasswordState.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppSizedBox(height: AppSize.s24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const CustomBackButton(),
                    ),
                    const AppSizedBox(height: AppSize.s24),
                    Image.asset(
                      AppPng.logo2,
                      width: AppSize.s120,
                      height: AppSize.s90,
                      fit: BoxFit.contain,
                    ),
                    const AppSizedBox(height: AppSize.s24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.changePasswordSubtitle,
                        style: getRegularStyle(
                          context: context,
                          color: AppColors.textPrimary,
                          fontSize: FontSizeManager.s18,
                        ).copyWith(height: 1.4),
                      ),
                    ),
                    const AppSizedBox(height: AppSize.s4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.createNewPassword,
                        style: getBoldStyle(
                          context: context,
                          color: AppColors.textPrimary,
                          fontSize: FontSizeManager.s20,
                        ).copyWith(height: 1.4),
                      ),
                    ),
                    const AppSizedBox(height: AppSize.s20),
                    CustomContainer(
                      borderRadius: 24,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _oldPasswordController,
                            hintText: context.oldPassword,
                            isPassword: true,
                            prefixIcon: _lockIcon(),
                            borderColor: AppColors.borderLight,
                            validator: AppValidator.password,
                          ),
                          const AppSizedBox(height: AppSize.s16),
                          CustomTextField(
                            controller: _newPasswordController,
                            hintText: AuthConstants.newPassword,
                            isPassword: true,
                            prefixIcon: _lockIcon(),
                            borderColor: AppColors.borderLight,
                            validator: (value) => AppValidator.newPassword(
                              value,
                              _oldPasswordController.text,
                            ),
                          ),
                          const AppSizedBox(height: AppSize.s16),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: AuthConstants.confirmPassword,
                            isPassword: true,
                            prefixIcon: _lockIcon(),
                            borderColor: AppColors.borderLight,
                            validator: (value) => AppValidator.confirmPassword(
                              value,
                              _newPasswordController.text,
                            ),
                          ),
                          const AppSizedBox(height: AppSize.s28),
                          state.changePasswordState.isLoading
                              ? const ButtonLoadingWidget()
                              : PrimaryButton(
                                  text: context.done,
                                  onTap: () => _onDone(context),
                                  height: AppSize.s38,
                                  borderRadius: AppSize.borderRadiusOutlined,
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    8,
                                    16,
                                    8,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const AppSizedBox(height: AppSize.s24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
