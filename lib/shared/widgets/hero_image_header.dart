import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;

/// 스팟/코스 상세 최상단에 노출되는 히어로 이미지 헤더.
///
/// [imageUrl]이 비어 있거나 로딩·오류일 때 "이미지 없음" 아이콘 대신
/// 브랜드 톤에 맞춘 야간 그라디언트 폴백을 보여준다. 선택적으로
/// [fallbackTitle]을 넘기면 폴백 화면에 스팟 이름을 함께 노출한다.
class HeroImageHeader extends StatelessWidget {
  const HeroImageHeader({
    super.key,
    required this.imageUrl,
    this.height = 340,
    this.fallbackTitle,
  });

  final String imageUrl;
  final double height;
  final String? fallbackTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl.trim().isEmpty)
            _HeroFallback(title: fallbackTitle)
          else
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const ColoredBox(color: AppColors.surfaceContainerHigh),
              errorWidget: (context, url, error) =>
                  _HeroFallback(title: fallbackTitle),
            ),
          // 하단 텍스트 가독성을 위한 그라디언트 오버레이
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

class _HeroFallback extends StatelessWidget {
  const _HeroFallback({this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceContainerHigh,
            AppColors.background,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.moonlightGold.withValues(alpha: 0.12),
                border: Border.all(
                  color: AppColors.moonlightGold.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.nights_stay_outlined,
                color: AppColors.moonlightGold,
                size: 32,
              ),
            ),
            if (title != null && title!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
