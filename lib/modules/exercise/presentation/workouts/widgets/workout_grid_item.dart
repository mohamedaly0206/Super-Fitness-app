import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';

class WorkoutGridItem extends StatelessWidget {
  final String image;
  final String title;

  const WorkoutGridItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
