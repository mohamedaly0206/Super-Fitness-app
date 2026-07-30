import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/widgets/custom_appbar.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/cubit/logout_cubit.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/widgets/logout_confirmation_dialog.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/widgets/logout_list_item.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      appBar: CustomAppBar(title: context.profile, showBackButton: false),
      body: BlocConsumer<LogoutCubit, LogoutState>(
        listenWhen: (previous, current) =>
            previous.logoutState != current.logoutState,
        listener: (context, state) {
          if (state.logoutState.data == true) {
            // TODO: Navigate to the Login screen after the authentication flow is integrated.
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (_) => const LoginPage()),
            //   (route) => false,
            // );
          } else if (state.logoutState.errorMessage != null) {
            CustomSnackBar.error(context, state.logoutState.errorMessage!);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: LogoutListItem(
              isLoading: state.logoutState.isLoading,
              onTap: () => showLogoutConfirmationDialog(context),
            ),
          );
        },
      ),
    );
  }
}
