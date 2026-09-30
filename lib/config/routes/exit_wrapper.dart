import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';

import '../../core/widgets/custom_snack_bar.dart';

class ExitWrapper extends StatefulWidget {
  final Widget child;

  const ExitWrapper({super.key, required this.child});

  @override
  State<ExitWrapper> createState() => _ExitWrapperState();
}

class _ExitWrapperState extends State<ExitWrapper> {
  DateTime? lastBackPress;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final now = DateTime.now();

        if (lastBackPress == null ||
            now.difference(lastBackPress!) > AppDurations.exitBackPress) {
          lastBackPress = now;

          CustomSnackBar.info(context, AppStrings.pressBackAgainToExit);
        } else {
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
