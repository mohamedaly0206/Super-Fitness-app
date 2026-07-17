import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/register_data.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_selection_card.dart';

class RegisterGoalView extends StatelessWidget {
  final PageController pageController;

  const RegisterGoalView({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<RegisterCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Expanded(
          flex: 3,
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomContainer(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: RegisterData.goals.length,
                        itemBuilder: (context, index) {
                          final goal = RegisterData.goals[index];
                          return RegisterSelectionCard(
                            title: goal,
                            isSelected: state.goal == goal,
                            onTap: () {
                              cubit.handleRegisterIntent(
                                SelectGoalIntent(goal),
                              );
                            },
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: state.goal == null
                            ? null
                            : () => pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                        child: Text(AuthConstants.next),
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
