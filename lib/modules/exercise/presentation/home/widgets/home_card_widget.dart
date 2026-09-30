import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/cached_network_image.dart';
import 'package:super_fitness_app/core/widgets/custom_container.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final Function()? onTap;

  const HomeCardWidget({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(AppPadding.p4),
        width: AppSize.s120,
        height: AppSize.s130,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.borderRadiusOutlined),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImageWidget(
                urlToImage: image,
                width: AppSize.s120,
                height: AppSize.s130,
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSize.borderRadiusOutlined),
                  ),
                  child: CustomContainer(
                    height: AppSize.s36,
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    borderRadius: AppSize.s0,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: FontSizeManager.s12,
                      ),
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
