import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart'
    show nowGoodSpotsProvider;

/// 지금 가기 좋은 스팟 전체 리스트 화면 (2depth).
///
/// 홈 화면 `_SectionHeader(actionLabel: '모두 보기')` 클릭 시
/// `context.push('/now-good-spots')`로 진입한다. 홈 상단 가로 스크롤 카드와
/// 동일한 [nowGoodSpotsProvider]를 사용하되, 여기서는 세로 스크롤 리스트로
/// 표시해 한눈에 훑어볼 수 있게 한다.
class NowGoodSpotsListPage extends ConsumerWidget {
  const NowGoodSpotsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotsAsync = ref.watch(nowGoodSpotsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
          tooltip: '뒤로',
        ),
        title: Text(
          '지금 가기 좋은 스팟',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: spotsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(
          child: Text(
            '오류: $e',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        data: (spots) {
          if (spots.isEmpty) {
            return Center(
              child: Text(
                '지금 가기 좋은 스팟이 없어요',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: spots.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) => _SpotListItem(spot: spots[index]),
          );
        },
      ),
    );
  }
}

/// 리스트 형식 스팟 카드.
///
/// 홈 화면 `_NowGoodSpotCard`(가로 카드용, 156 높이)와 달리 세로 리스트용으로
/// 풀 폭·정보 밀도 높은 레이아웃을 사용한다. 탭 시 스팟 상세(`/spot/:slug`)로 이동.
class _SpotListItem extends StatelessWidget {
  const _SpotListItem({required this.spot});
  final SpotSummary spot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/spot/${spot.slug}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  spot.heroImageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 160,
                    color: AppColors.surfaceContainerHigh,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Row(
                    children: [
                      if (spot.forecastStatus == 'forecast_available' &&
                          spot.crowdLevel != null)
                        _StatBadge(
                          icon: Icons.people_outline,
                          label: spot.crowdLevel!,
                        ),
                      if (spot.distanceM != null) ...[
                        const SizedBox(width: 6),
                        _StatBadge(
                          icon: Icons.near_me_outlined,
                          label: '${spot.distanceM!.toStringAsFixed(0)}m',
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    style: AppTextStyles.headlineMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    spot.reasonLabel,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.moonlightGold),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }
}
