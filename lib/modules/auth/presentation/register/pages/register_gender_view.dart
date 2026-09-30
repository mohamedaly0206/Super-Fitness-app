import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/cubit/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/gender_card.dart';

class RegisterGenderView extends StatelessWidget {
  const RegisterGenderView({super.key, required this.pageController});
  final PageController pageController;

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
            children: [
              Text(
                AuthConstants.tellUsAboutYourself,
                style: getExtraBoldStyle(
                  context: context,
                  color: theme.colorScheme.onPrimary,
                  fontSize: FontSizeManager.s20,
                ),
              ),
              Text(
                AuthConstants.weNeedToKnowYourGender,
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
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return CustomContainer(
              child: Column(
                children: [
                  GenderCard(
                    title: AuthConstants.male,
                    icon: AppSvg.male,
                    selected: state.gender == Gender.male,
                    onTap: () {
                      cubit.doEvent(SelectGenderEvent(Gender.male));
                    },
                  ),
                  const SizedBox(height: 20),

                  GenderCard(
                    title: AuthConstants.female,
                    icon: AppSvg.female,
                    selected: state.gender == Gender.female,
                    onTap: () {
                      cubit.doEvent(SelectGenderEvent(Gender.female));
                    },
                  ),
                  SizedBox(height: AppSize.s24),
                  PrimaryButton(
                    text: AuthConstants.next,
                    onTap: state.gender == null
                        ? null
                        : () => pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
