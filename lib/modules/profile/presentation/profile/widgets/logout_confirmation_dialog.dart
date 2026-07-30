import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/cubit/logout_cubit.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) {
  final logoutCubit = context.read<LogoutCubit>();

  return showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: logoutCubit,
      child: const LogoutConfirmationDialog(),
    ),
  );
}

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  static const double _buttonWidth = 80;
  static const double _buttonHeight = 38;
  static const double _buttonRadius = 20;
  static const double _buttonGap = 60;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.glassFill,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadiusCard),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.logoutConfirmationTitle,
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(
                context: context,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _buttonWidth,
                  height: _buttonHeight,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      context.no,
                      style: getSemiBoldStyle(
                        context: context,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: _buttonGap),
                SizedBox(
                  width: _buttonWidth,
                  height: _buttonHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<LogoutCubit>().logout();
                    },
                    child: Text(
                      context.yes,
                      style: getSemiBoldStyle(
                        context: context,
                        color: AppColors.textWhite,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
