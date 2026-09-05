import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_filters.dart'
    show NearbyFilters;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show nearbyFiltersControllerProvider;

/// 리스트 상단에 노출되는 활성 필터 chip 리스트.
///
/// 기본값과 다른 필터만 chip으로 표시하고, 각 chip의 × 버튼으로 개별 해제할 수 있다.
/// 활성 필터가 하나라도 있으면 우측에 "초기화" 텍스트 버튼을 노출한다.
class NearbyActiveFiltersRow extends ConsumerWidget {
  const NearbyActiveFiltersRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(nearbyFiltersControllerProvider);
    final controller = ref.read(nearbyFiltersControllerProvider.notifier);

    if (filters.isDefault) {
      return const SizedBox.shrink();
    }

    final chips = <Widget>[];
    if (filters.radiusM != NearbyFilters.defaultRadiusM) {
      chips.add(
        _FilterChip(
          label: _formatRadius(filters.radiusM),
          icon: Icons.near_me,
          onRemove: () => controller.setRadius(NearbyFilters.defaultRadiusM),
        ),
      );
    }
    if (filters.sortBy != NearbySortBy.distance) {
      chips.add(
        _FilterChip(
          label: filters.sortBy.label,
          icon: Icons.sort,
          onRemove: () => controller.setSortBy(NearbySortBy.distance),
        ),
      );
    }
    for (final level in filters.crowdLevels) {
      chips.add(
        _FilterChip(
          label: level,
          icon: Icons.people_outline,
          onRemove: () => controller.toggleCrowdLevel(level),
        ),
      );
    }

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: chips.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == chips.length) {
            return Center(
              child: TextButton(
                onPressed: controller.reset,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '초기화',
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.moonlightGold,
                  ),
                ),
              ),
            );
          }
          return chips[index];
        },
      ),
    );
  }

  static String _formatRadius(int radiusM) {
    if (radiusM >= 1000) return '${radiusM ~/ 1000}km 이내';
    return '${radiusM}m 이내';
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.onRemove,
  });

  final String label;
  final IconData icon;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 6, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.moonlightGold),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(width: 4),
          Semantics(
            label: '$label 필터 제거',
            button: true,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
