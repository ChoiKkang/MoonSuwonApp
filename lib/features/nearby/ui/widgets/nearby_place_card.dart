import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;

/// '내 주변' 리스트의 1개 스팟 카드.
///
/// 좌측에 대표 이미지, 우측에 이름/야간 포인트/거리 뱃지를 표시한다.
/// 지도 마커와 클릭 상호작용을 공유하도록 [isSelected]로 하이라이트한다.
class NearbyPlaceCard extends StatelessWidget {
  const NearbyPlaceCard({
    super.key,
    required this.place,
    required this.isSelected,
    required this.onTap,
  });

  final NearbyPlace place;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.moonlightGold
        : AppColors.glassBorder;

    return Semantics(
      button: true,
      label: '${place.displayName}, ${_formatDistance(place.distanceM)}',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CardImage(imageUrl: place.heroImageUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      place.displayName,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ((place.nightHighlight ?? '').trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        place.nightHighlight!,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _DistanceBadge(distanceM: place.distanceM),
                        if (place.hasForecast &&
                            (place.crowdLevel ?? '').isNotEmpty) ...[
                          const SizedBox(width: 6),
                          _CrowdBadge(level: place.crowdLevel!),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        height: 72,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? _placeholder()
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, _) => _placeholder(),
                errorWidget: (_, _, _) => _placeholder(),
              ),
      ),
    );
  }

  Widget _placeholder() => Container(
    color: AppColors.surfaceContainerHigh,
    alignment: Alignment.center,
    child: const Icon(
      Icons.image_outlined,
      color: AppColors.onSurfaceVariant,
      size: 24,
    ),
  );
}

class _DistanceBadge extends StatelessWidget {
  const _DistanceBadge({required this.distanceM});
  final double distanceM;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.near_me,
            size: 12,
            color: AppColors.moonlightGold,
          ),
          const SizedBox(width: 4),
          Text(
            _formatDistance(distanceM),
            style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }
}

class _CrowdBadge extends StatelessWidget {
  const _CrowdBadge({required this.level});
  final String level;

  static const _colors = <String, Color>{
    '여유': Color(0xFF34D399), // green-ish
    '보통': Color(0xFFF59E0B), // softAmber
    '혼잡': Color(0xFFFB7185), // rose
  };

  @override
  Widget build(BuildContext context) {
    final accent = _colors[level] ?? AppColors.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 12, color: accent),
          const SizedBox(width: 4),
          Text(
            level,
            style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }
}

String _formatDistance(double meters) {
  if (meters < 1000) return '${meters.round()}m';
  return '${(meters / 1000).toStringAsFixed(1)}km';
}
