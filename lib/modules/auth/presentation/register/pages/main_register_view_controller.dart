import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_activity_level_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_age_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_gender_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_goals_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_height_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_page.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/pages/register_weight_view.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/circular_progress_indicator.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/custom_register_back_button.dart';

class MainRegisterViewController extends StatelessWidget {
  MainRegisterViewController({super.key});

  final PageController pageController = PageController();
  final int totalSteps = 6;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {},
        child: CustomScaffold(
          background: Backgrounds.register,
          body: Padding(
            padding: const EdgeInsets.only(top: AppPadding.p32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  child: AnimatedBuilder(
                    animation: pageController,
                    builder: (context, child) {
                      int currentPageIndex = 0;
                      double exactPageValue = 0.0;
                      if (pageController.hasClients) {
                        exactPageValue = pageController.page ?? 0;
                        currentPageIndex = exactPageValue.round();
                      }
                      bool isNotFirstPage = currentPageIndex > 0;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: isNotFirstPage
                                      ? CustomRegisterBackButton(
                                          pageController: pageController,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                              Image.asset(
                                AppPng.logo,
                                height: AppSize.s100,
                                width: AppSize.s100,
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          if (isNotFirstPage) ...[
                            const SizedBox(height: AppSize.s100),
                            StepProgressIndicator(
                              currentStep: currentPageIndex,
                              exactProgress: (exactPageValue) / totalSteps,
                              totalSteps: totalSteps,
                              activeColor: theme.colorScheme.primary,
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s8),

                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      RegisterPage(pageController: pageController),
                      RegisterGenderView(pageController: pageController),
                      RegisterAgeView(pageController: pageController),
                      RegisterWeightView(pageController: pageController),
                      RegisterHeightView(pageController: pageController),
                      RegisterGoalView(pageController: pageController),
                      RegisterActivityLevelView(pageController: pageController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
