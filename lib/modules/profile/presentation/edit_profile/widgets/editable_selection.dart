import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/profile_constants.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';

class EditableSelection extends StatelessWidget {
  const EditableSelection({
    super.key,
    required this.title,
    required this.selectionInfo,
    required this.onTap,
  });
  final String title;
  final String selectionInfo;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: '$title (',
            style: getSemiBoldStyle(
              context: context,
              fontSize: FontSizeManager.s14,
              color: theme.colorScheme.onPrimary, // Your white color
            ),
            children: [
              TextSpan(
                text: context.tapToEdit,
                style: getSemiBoldStyle(
                  context: context,
                  fontSize: FontSizeManager.s14,
                  color: theme.colorScheme.primary,
                ),
              ),
              TextSpan(
                text: ')',
                style: getSemiBoldStyle(
                  context: context,
                  fontSize: FontSizeManager.s14,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        AppSizedBox(height: AppSize.s8),
        InkWell(
          onTap: onTap,
          child: Container(
            height: AppSize.s36,
            width: double.infinity,
            decoration: BoxDecoration(
              // transparent color
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.21),
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: theme.colorScheme.onPrimaryContainer,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
                vertical: AppPadding.p8,
              ),
              child: Text(
                selectionInfo,
                style: getBoldStyle(
                  context: context,
                  fontSize: FontSizeManager.s12,
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
