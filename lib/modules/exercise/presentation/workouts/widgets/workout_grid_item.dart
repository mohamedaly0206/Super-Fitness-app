import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';

class WorkoutGridItem extends StatelessWidget {
  final String image;
  final String title;

  const WorkoutGridItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusSnackBar),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImageWidget(
            urlToImage: image,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withValues(alpha: 0.3)),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizeManager.s17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
