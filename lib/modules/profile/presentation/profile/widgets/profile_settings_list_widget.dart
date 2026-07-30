import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'profile_item_data.dart';

class ProfileSettingsListWidget extends StatelessWidget {
  const ProfileSettingsListWidget({super.key, required this.items});

  final List<ProfileItemData> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s16,
                    vertical: AppSize.s12,
                  ),
                  child: Row(
                    children: [
                      if (item.leadingIcon != null) ...[
                        item.leadingIcon!,
                        SizedBox(width: AppSize.s16),
                      ],
                      Expanded(
                        child:
                            item.customTitleWidget ??
                            Text(
                              item.title,
                              style: getSemiBoldStyle(
                                context: context,
                                color: item.textColor ?? AppColors.textWhite,
                                fontSize: AppSize.s16,
                              ),
                            ),
                      ),
                      item.trailing ??
                          Icon(
                            Icons.arrow_forward_ios,
                            color: theme.colorScheme.primary,
                            size: AppSize.s16,
                          ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Divider(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1,
                  thickness: 1,
                  indent: AppSize.s16,
                  endIndent: AppSize.s16,
                ),
            ],
          );
        }),
      ),
    );
  }
}
