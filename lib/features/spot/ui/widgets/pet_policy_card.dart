import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;

/// 반려동물 동반 정보 카드.
///
/// 정책은 웹/앱이 공유하는 작은 어휘(allowed/partial/not_allowed/unknown)를
/// 쓴다. 데이터가 없는 상태(unknown)를 "가능"으로 보이게 하지 않는다.
/// 정책이 unknown이고 안내 문구도 없으면 카드를 렌더하지 않는다.
class PetPolicyCard extends StatelessWidget {
  const PetPolicyCard({super.key, required this.policy, required this.note});

  final String policy;
  final String note;

  /// 표시할 내용이 있는지. unknown이면서 안내 문구가 없으면 감춘다.
  static bool shouldShow({required String policy, required String note}) {
    return policy == 'allowed' ||
        policy == 'partial' ||
        policy == 'not_allowed' ||
        note.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldShow(policy: policy, note: note)) {
      return const SizedBox.shrink();
    }

    final status = _statusFor(policy);
    final trimmedNote = note.trim();

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
              const Icon(Icons.pets, size: 20, color: AppColors.softAmber),
              const SizedBox(width: 10),
              Text(
                '반려동물 동반',
                style: AppTextStyles.headlineMd.copyWith(fontSize: 18),
              ),
              const Spacer(),
              _StatusPill(status: status),
            ],
          ),
          if (trimmedNote.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              trimmedNote,
              style: AppTextStyles.bodyMd.copyWith(
                fontSize: 14,
                color: AppColors.onSurface,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            '방문 전 현장 상황에 따라 달라질 수 있어요. 안내견은 어디서나 동반할 수 있습니다.',
            style: AppTextStyles.labelSm.copyWith(color: AppColors.outline),
          ),
        ],
      ),
    );
  }

  _PetStatus _statusFor(String policy) {
    switch (policy) {
      case 'allowed':
        return const _PetStatus('동반 가능', AppColors.moonlightGold);
      case 'partial':
        return const _PetStatus('일부 가능', AppColors.softAmber);
      case 'not_allowed':
        return const _PetStatus('동반 불가', AppColors.error);
      default:
        return const _PetStatus('정보 확인 필요', AppColors.outline);
    }
  }
}

class _PetStatus {
  const _PetStatus(this.label, this.color);

  final String label;
  final Color color;
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final _PetStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.labelSm.copyWith(
          color: status.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
