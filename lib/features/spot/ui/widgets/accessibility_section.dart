import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts, AccessibilityGroup;

/// 편의시설과 접근성(무장애 여행 정보) 섹션.
///
/// 한국관광공사 무장애 여행 정보를 원문 그대로, 확인된 항목만 보여준다.
/// 등급으로 환산하지 않는다. 값이 없는 항목과 빈 그룹은 [AccessibilityFacts]가
/// 이미 걸러 낸다. 호출부는 [AccessibilityFacts.hasInfo]가 true일 때만 렌더한다.
class AccessibilitySection extends StatelessWidget {
  const AccessibilitySection({super.key, required this.facts});

  final AccessibilityFacts facts;

  @override
  Widget build(BuildContext context) {
    final groups = facts.groups;
    if (groups.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.accessible_forward,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '편의시설과 접근성',
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '밤에는 낮보다 길이 어둡고 경사가 더 부담스럽습니다. 확인된 항목만 표시합니다.',
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < groups.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            _AccessibilityGroupView(group: groups[i]),
          ],
          const SizedBox(height: 16),
          Divider(color: AppColors.glassBorder, height: 1),
          const SizedBox(height: 12),
          Text(
            _sourceLabel(facts.sourceUpdatedAt),
            style: AppTextStyles.labelSm.copyWith(color: AppColors.outline),
          ),
        ],
      ),
    );
  }

  String _sourceLabel(String? updatedAt) {
    const base = '한국관광공사 무장애 여행 정보 기준입니다. 방문 전 현장에 다시 확인해 주세요.';
    if (updatedAt == null || updatedAt.trim().isEmpty) return base;
    return '$base (${updatedAt.trim()} 기준)';
  }
}

class _AccessibilityGroupView extends StatelessWidget {
  const _AccessibilityGroupView({required this.group});

  final AccessibilityGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.title,
          style: AppTextStyles.labelMd.copyWith(color: AppColors.moonlightGold),
        ),
        const SizedBox(height: 8),
        ...group.items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 68,
                  child: Text(
                    item.label,
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.value,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontSize: 14,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
