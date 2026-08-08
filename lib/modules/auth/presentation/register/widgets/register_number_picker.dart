import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/auth_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:wheel_slider/wheel_slider.dart';

class RegisterNumberPickerView extends StatelessWidget {
  final PageController pageController;
  final String title;
  final num currentValue;
  final num startRange;
  final num endRange;
  final String unit;
  final bool isNextEnabled;
  final Function(num) onChanged;

  const RegisterNumberPickerView({
    super.key,
    required this.pageController,
    required this.title,
    required this.currentValue,
    required this.onChanged,
    required this.startRange,
    required this.endRange,
    required this.unit,
    required this.isNextEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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

          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  unit,
                  style: getRegularStyle(
                    context: context,
                    color: theme.colorScheme.primary,
                    fontSize: FontSizeManager.s12,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: WheelSlider.number(
                    isInfinite: false,
                    perspective: 0.003,
                    totalCount: endRange.toInt() + 1,
                    initValue: currentValue.toInt(),
                    currentIndex: currentValue.toInt(),
                    itemSize: 80,
                    showPointer: false,
                    selectedNumberStyle: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                    unSelectedNumberStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onValueChanged: (val) {
                      onChanged(val);
                    },
                    hapticFeedbackType: HapticFeedbackType.vibrate,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_up, // The little triangle
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(height: AppSize.s12),
                PrimaryButton(
                  text: AuthConstants.next,
                  onTap: isNextEnabled
                      ? () => pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        )
                      : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSize.s42),
        ],
      ),
    );
  }
}
