import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final Function()?   onTap;
  
  const HomeCardWidget({super.key, required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:onTap ,
    child: Container(
      margin: EdgeInsets.all(4),
      width: 120,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
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
    ),
  );
  }
}