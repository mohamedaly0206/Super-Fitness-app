import 'package:flutter/material.dart';
import 'package:super_fitness_app/modules/profile/presentation/profile/widgets/profile_item_data.dart';

import '../../../../../core/layout/app_size.dart';
import '../../../../../core/theme/app_text_style.dart';

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
                      item.leadingIcon,
                      SizedBox(width: AppSize.s16),
                      Expanded(
                        child: Text(
                          item.title,
                          style: getSemiBoldStyle(
                            context: context,
                            color: theme.colorScheme.onPrimary,
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
