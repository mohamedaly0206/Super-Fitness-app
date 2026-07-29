import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/theme/font_size_manager.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool hasPhoto = true;
    final String? photoUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500';

    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),
            ProfileImage(
              hasPhoto: hasPhoto,
              photoUrl: photoUrl,
            ),
            AppSizedBox(
              height: 7,
            ),
            Text(
              'Khalid Adel',
              style: getBoldStyle(
                context: context,
                color: AppColors.textWhite,
                fontSize: FontSizeManager.s22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}