import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final bool hasPhoto;
  final String? photoUrl;

  const ProfileImage({
    super.key,
    required this.hasPhoto,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      backgroundImage: hasPhoto && photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: !hasPhoto || photoUrl == null
          ? const Icon(
        Icons.person,
        color: AppColors.primary,
        size: 42,
      )
          : null,
    );
  }
}