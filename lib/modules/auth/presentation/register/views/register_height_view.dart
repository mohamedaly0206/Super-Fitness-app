import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/cubit/register_cubit.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/intent/register_intent.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/view_model/state/register_state.dart';
import 'package:super_fitness_app/modules/auth/presentation/register/widgets/register_number_picker.dart';

class RegisterHeightView extends StatelessWidget {
  const RegisterHeightView({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return RegisterNumberPickerView(
          pageController: pageController,
          title: AuthConstants.whatIsYourHight,
          unit: AuthConstants.cm,
          currentValue: state.height ?? 150,
          startRange: 150,
          endRange: 250,
          isNextEnabled: state.height! >= 80,
          onChanged: (val) => context
              .read<RegisterCubit>()
              .handleRegisterIntent(SelectHeightIntent(val)),
        );
      },
    );
  }
}
