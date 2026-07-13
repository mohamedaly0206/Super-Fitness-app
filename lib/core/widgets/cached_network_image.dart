import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/network/endpoints.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String urlToImage;
  final double width;
  final double height;
  const CachedNetworkImageWidget({
    super.key,
    required this.urlToImage,
    this.width = AppSize.s60,
    this.height = AppSize.s60,
  });

  String get _fullUrl {
    if (urlToImage.startsWith('http://') || urlToImage.startsWith('https://')) {
      return urlToImage;
    }
    return '${AppConfig.baseUrl}$urlToImage';
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      memCacheHeight: 400,
      width: width,
      imageUrl: _fullUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => ImageShimmer(width: width, height: height),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: AppColors.error, size: AppSize.s24),
    );
  }
}
