import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/register_data.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_selection_card.dart';

class RegisterActivityLevelView extends StatelessWidget {
  final PageController pageController;
  const RegisterActivityLevelView({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<RegisterCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthConstants.yourRegularPhysicalActivityLevel,
                style: getExtraBoldStyle(
                  context: context,
                  color: theme.colorScheme.onPrimary,
                  fontSize: FontSizeManager.s20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s16),
        Expanded(
          flex: 2,
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (BuildContext context, RegisterState state) {
              final isLoading =
                  state.isEmailRegisterLoading ||
                  state.isGoogleRegisterLoading ||
                  state.isFacebookRegisterLoading;
              if (isLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AppLoadingWidget(),
                );
              }
              if (state.registerState.data != null && !isLoading) {
                Navigator.pop(context);
                CustomSnackBar.success(
                  context,
                  AuthConstants.registerSuccessMessage,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              }
              if (state.registerState.errorMessage != null) {
                Navigator.pop(context);
                CustomSnackBar.error(
                  context,
                  state.registerState.errorMessage!,
                );
              }
            },
            builder: (context, state) {
              return CustomContainer(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: RegisterData.activityLevels.length,
                        itemBuilder: (context, index) {
                          final activityKey = RegisterData.activityLevels.keys
                              .elementAt(index);
                          final activityValue =
                              RegisterData.activityLevels[activityKey]!;
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
                      state.isEmailRegisterLoading
                          ? const ButtonLoadingWidget()
                          : PrimaryButton(
                              text: AuthConstants.startYourJourney,
                              onTap: state.activityLevel == null
                                  ? null
                                  : () {
                                      final request = RegisterRequestEntity(
                                        firstName: state.firstName ?? "",
                                        lastName: state.lastName ?? "",
                                        email: state.email ?? "",
                                        password: state.password ?? "",
                                        rePassword: state.rePassword ?? "",
                                        gender: state.gender,
                                        age: state.age ?? 0,
                                        weight: state.weight ?? 0,
                                        height: state.height ?? 0,
                                        goal: state.goal ?? "",
                                        activityLevel:
                                            state.activityLevel ?? "",
                                      );
                                      cubit.doEvent(
                                        SubmitRegisterEvent(request: request),
                                      );
                                    },
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(child: const SizedBox()),
      ],
    );
  }
}
