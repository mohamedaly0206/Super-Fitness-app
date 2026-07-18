import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/onboarding_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/onboarding_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/cubit/onboarding_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/onboarding_actions.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/skip_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final currentItem = cubit.items[state.currentPage];

        return CustomScaffold(
          background: Backgrounds.onboarding,
          body: Stack(
            children: [
              const Positioned(top: 50, right: 20, child: SkipButton()),

              /// Images
              PageView.builder(
                controller: cubit.pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.items.length,
                onPageChanged: (index) {
                  cubit.doIntent(PageChangedIntent(index));
                },
                itemBuilder: (_, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: cubit.items[index].image,
                      child: Image.asset(
                        cubit.items[index].image,
                        height: MediaQuery.of(context).size.height * .70,
                        width: MediaQuery.of(context).size.width * .90,

                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),

              /// Bottom Glass Card
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .35,
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: .30),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p24,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                currentItem.title,
                                key: ValueKey(currentItem.title),
                                textAlign: TextAlign.center,
                                style: getBoldStyle(
                                  context: context,
                                  fontSize: 22,
                                  color: AppColors.surface,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                currentItem.description,
                                key: ValueKey(currentItem.description),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                  context: context,
                                  fontSize: 14,
                                  color: AppColors.surface.withValues(
                                    alpha: .8,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            OnboardingActions(
                              currentIndex: state.currentPage,
                              totalPages: cubit.items.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
