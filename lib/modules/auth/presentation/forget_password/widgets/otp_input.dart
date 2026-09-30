import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

class OtpInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool hasError;

  const OtpInput({super.key, required this.onChanged, required this.hasError});

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 70,
      height: 50,
      textStyle: getBoldStyle(
        context: context,
        fontSize: 26,
        color: hasError ? AppColors.error : AppColors.primary,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: hasError ? AppColors.error : Colors.white,
            width: 2,
          ),
        ),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: hasError ? AppColors.error : AppColors.primary,
            width: 3,
          ),
        ),
      ),
    );

    final submittedTheme = defaultTheme.copyWith(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: hasError ? AppColors.error : AppColors.primary,
            width: 3,
          ),
        ),
      ),
    );

    final errorTheme = defaultTheme.copyWith(
      textStyle: getBoldStyle(
        context: context,
        fontSize: 26,
        color: AppColors.error,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.error, width: 3)),
      ),
    );

    return Center(
      child: Pinput(
        length: 4,
        keyboardType: TextInputType.number,
        autofocus: true,
        showCursor: false,
        defaultPinTheme: defaultTheme,
        focusedPinTheme: focusedTheme,
        submittedPinTheme: submittedTheme,
        errorPinTheme: errorTheme,

        separatorBuilder: (_) => const AppSizedBox(width: 20),
        forceErrorState: hasError,
        onChanged: onChanged,
      ),
    );
  }
}
