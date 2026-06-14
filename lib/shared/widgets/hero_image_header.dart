import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;

class HeroImageHeader extends StatelessWidget {
  const HeroImageHeader({
    super.key,
    required this.imageUrl,
    this.height = 340,
  });

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.surfaceContainerHigh,
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.surfaceContainerHigh,
              child: const Icon(Icons.image_not_supported_outlined,
                  color: AppColors.onSurfaceVariant),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background.withValues(alpha: 0.4),
                  AppColors.background,
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
