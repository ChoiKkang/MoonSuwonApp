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

/// '내 주변' 필터 선택 바텀시트.
///
/// - 반경 500m/1km/3km/5km 중 하나 (라디오)
/// - 정렬: 거리 / 추천 / 야간 명소 (라디오)
/// - 혼잡도: 여유 / 보통 / 혼잡 (다중 선택)
///
/// 필터 변경은 즉시 [NearbyFiltersController]로 반영되어 리스트/지도가 실시간
/// 갱신된다. 시트 하단 "초기화" 버튼으로 모든 필터를 기본값으로 되돌린다.
class NearbyFilterSheet extends ConsumerWidget {
  const NearbyFilterSheet({super.key});

  /// 앱 어디서든 시트를 띄우기 위한 편의 함수.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const NearbyFilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(nearbyFiltersControllerProvider);
    final controller = ref.read(nearbyFiltersControllerProvider.notifier);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 핸들
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('필터', style: AppTextStyles.headlineMd),
                const Spacer(),
                if (!filters.isDefault)
                  TextButton(
                    onPressed: controller.reset,
                    child: Text(
                      '초기화',
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.moonlightGold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionTitle(title: '반경'),
            const SizedBox(height: 8),
            _RadiusRow(
              currentRadiusM: filters.radiusM,
              onSelected: controller.setRadius,
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: '정렬'),
            const SizedBox(height: 8),
            _SortRow(
              current: filters.sortBy,
              onSelected: controller.setSortBy,
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: '혼잡도'),
            const SizedBox(height: 8),
            _CrowdRow(
              selected: filters.crowdLevels,
              onToggle: controller.toggleCrowdLevel,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.moonlightGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(
                  '적용',
                  style: AppTextStyles.labelMd.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _RadiusRow extends StatelessWidget {
  const _RadiusRow({required this.currentRadiusM, required this.onSelected});
  final int currentRadiusM;
  final ValueChanged<int> onSelected;

  static String _formatRadius(int radiusM) {
    if (radiusM >= 1000) return '${radiusM ~/ 1000}km';
    return '${radiusM}m';
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final option in NearbyFilters.radiusOptionsM)
          _ChoiceChip(
            label: _formatRadius(option),
            selected: currentRadiusM == option,
            onTap: () => onSelected(option),
          ),
      ],
    );
  }
}

class _SortRow extends StatelessWidget {
  const _SortRow({required this.current, required this.onSelected});
  final NearbySortBy current;
  final ValueChanged<NearbySortBy> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final option in NearbySortBy.values)
          _ChoiceChip(
            label: option.label,
            selected: current == option,
            onTap: () => onSelected(option),
          ),
      ],
    );
  }
}

class _CrowdRow extends StatelessWidget {
  const _CrowdRow({required this.selected, required this.onToggle});
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final level in NearbyFilters.crowdLevelOptions)
          _ChoiceChip(
            label: level,
            selected: selected.contains(level),
            onTap: () => onToggle(level),
          ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.moonlightGold
              : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.moonlightGold : AppColors.glassBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            color: selected ? Colors.black : AppColors.onSurface,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
