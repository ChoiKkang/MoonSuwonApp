import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaButton;

class ArrivalModal extends StatelessWidget {
  const ArrivalModal({
    super.key,
    required this.spotName,
    required this.currentIndex,
    required this.totalCount,
    required this.missionPrompt,
    required this.onMissionTap,
    required this.onNextSpotTap,
    required this.onDismiss,
  });

  final String spotName;
  final int currentIndex;
  final int totalCount;
  final String missionPrompt;
  final VoidCallback onMissionTap;
  final VoidCallback onNextSpotTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'CURRENT PROGRESS',
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.moonlightGold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$currentIndex/$totalCount 스팟',
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$spotName에\n도착했습니다!',
            style: AppTextStyles.headlineLg.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 8),
          Text(
            missionPrompt,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          MoonlightCtaButton(
            label: '포토 미션 확인하기',
            icon: Icons.camera_alt_outlined,
            onPressed: onMissionTap,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: onNextSpotTap,
              icon: const Icon(Icons.near_me_outlined, size: 18),
              label: const Text('다음 스팟 길찾기'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onSurface,
                side: BorderSide(color: AppColors.glassBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
