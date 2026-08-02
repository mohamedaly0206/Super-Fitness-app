import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_event.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/onboarding_actions.dart';
import 'package:super_fitness_app/modules/auth/presentation/onboarding/widgets/skip_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.navigateToLogin) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      builder: (context, state) {
        final currentItem = cubit.items[state.currentPage];

        return CustomScaffold(
          background: Backgrounds.onboarding,
          body: Stack(
            children: [
              /// Images
              PageView.builder(
                controller: cubit.pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.items.length,
                onPageChanged: (index) {
                  cubit.doEvent(PageChangedEvent(index));
                },
                itemBuilder: (_, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: cubit.items[index].image,
                      child: Image.asset(
                        cubit.items[index].image,
                        height: MediaQuery.of(context).size.height * .90,
                        width: MediaQuery.of(context).size.width * .99,
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
                  height: MediaQuery.of(context).size.height * .32,
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
                      filter: ImageFilter.blur(sigmaX: 35, sigmaY: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p10,
                        ),
                        child: Column(
                          children: [
                            AppSizedBox(height: 30),
                            Text(
                              currentItem.title,
                              key: ValueKey(currentItem.title),
                              textAlign: TextAlign.center,
                              style: getBoldStyle(
                                context: context,
                                fontSize: 22,
                                color: AppColors.surface,
                              ),
                            ),
                            const AppSizedBox(height: 16),
                            Text(
                              currentItem.description,
                              key: ValueKey(currentItem.description),
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                context: context,
                                fontSize: 14,
                                color: AppColors.surface.withValues(alpha: .8),
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
              // Skip Button
              const Positioned(top: 50, right: 20, child: SkipButton()),
            ],
          ),
        );
      },
    );
  }
}
