import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

Widget homeCard({required String image, required String title}) {
  return Container(
    margin: EdgeInsets.all(4),
    width: 120,
    height: 130,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImageWidget(urlToImage: image, width: 120, height: 130),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: CustomContainer(
                height: 36,
                width: double.infinity,
                padding: EdgeInsets.zero,
                borderRadius: 0,
                alignment: Alignment.center,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}