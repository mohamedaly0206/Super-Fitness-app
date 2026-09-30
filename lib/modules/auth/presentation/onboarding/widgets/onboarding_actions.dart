import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/onboarding_indicator.dart';

class OnboardingActions extends StatelessWidget {
  final int currentIndex;
  final int totalPages;

  const OnboardingActions({
    super.key,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final state = context.watch<OnboardingCubit>().state;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p24,
        0,
        AppPadding.p24,
        AppPadding.p24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingIndicator(
            controller: cubit.pageController,
            count: totalPages,
          ),
          const AppSizedBox(height: 24),
          if (state.isFirstPage)
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Next',
                onTap: () {
                  cubit.doEvent(const NextPressedEvent());
                },
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      cubit.doEvent(const BackPressedEvent());
                    },
                    child: Text(
                      'Back',
                      style: getSemiBoldStyle(
                        context: context,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const AppSizedBox(width: 150),
                Expanded(
                  child: PrimaryButton(
                    text: state.isLastPage ? 'Do it' : 'Next',
                    onTap: () {
                      if (state.isLastPage) {
                        cubit.doEvent(const FinishPressedEvent());
                      } else {
                        cubit.doEvent(const NextPressedEvent());
                      }
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
