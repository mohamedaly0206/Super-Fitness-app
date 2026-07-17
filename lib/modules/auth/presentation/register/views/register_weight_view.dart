import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_number_picker.dart';

class RegisterWeightView extends StatelessWidget {
  const RegisterWeightView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return RegisterNumberPickerView(
          pageController: pageController,
          title: AuthConstants.whatIsYourWeight,
          unit: AuthConstants.kg,
          currentValue: state.weight ?? 60,
          startRange: 40,
          endRange: 200,
          isNextEnabled: state.weight! >= 40,
          onChanged: (val) => context
              .read<RegisterCubit>()
              .handleRegisterIntent(SelectWeightIntent(val)),
        );
      },
    );
  }
}
