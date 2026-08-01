import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/widgets/custom_number_picker_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_intent.dart';
import 'package:super_fitness_app/modules/profile/presentation/edit_profile/cubit/edit_profile_state.dart';
import '../cubit/edit_profile_cubit.dart';

class EditWeightPage extends StatelessWidget {
  const EditWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              return RegisterNumberPickerWidget(
                title: AuthConstants.whatIsYourWeight,
                unit: AuthConstants.kg,
                currentValue: state.weight ?? 60,
                startRange: 40,
                endRange: 200,
                isNextEnabled: (state.weight ?? 60) >= 40,
                onPressed: () => Navigator.pop(context),
                onChanged: (val) => context
                    .read<EditProfileCubit>()
                    .handleEditProfileIntent(SelectWeightIntent(val.toInt())),
              );
            },
          ),
        ),
      ),
    );
  }
}
