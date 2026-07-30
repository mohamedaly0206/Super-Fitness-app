import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/localization_constants/smart_coach_constants.dart';
import 'package:super_fitness_app/core/resources/app_png.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_intent.dart';
import 'package:super_fitness_app/modules/smart_coach/presentation/cubit/smart_coach_state.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.chat,
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            const Spacer(),

            Image.asset(
              AppPng.robot,
              width: 350,
              fit: BoxFit.contain,
            ),

            const Spacer(),

            CustomContainer(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
              borderRadius: 36,
              border: Border.all(
                color: Colors.white.withValues(alpha: .08),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.assistYou,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  BlocBuilder<SmartCoachCubit, SmartCoachState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const ButtonLoadingWidget();
                      }

                      return PrimaryButton(
                        text: context.getStarted,
                        onTap: () {
                          context.read<SmartCoachCubit>().doIntent(
                            const CreateNewConversationIntent(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
