import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_number_picker.dart';

class RegisterAgeView extends StatelessWidget {
  final PageController pageController;
  const RegisterAgeView({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return RegisterNumberPickerView(
          pageController: pageController,
          title: AuthConstants.howOldAreYou,
          currentValue: state.age ?? 15,
          startRange: 10,
          endRange: 100,
          isNextEnabled: state.age! >= 15,
          onChanged: (val) => context
              .read<RegisterCubit>()
              .handleRegisterIntent(SelectAgeIntent(val)),
          unit: AuthConstants.year,
        );
      },
    );
  }
}
