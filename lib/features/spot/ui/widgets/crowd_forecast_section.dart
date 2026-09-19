import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show DailyCrowd;
import 'package:dalbit_suwon/features/spot/provider/crowd_provider.dart'
    show crowdForecastProvider;

/// 예측 혼잡도 섹션(날짜별).
///
/// 한국관광공사 관광지 혼잡도 "예측"이라 날짜 단위다. 오늘부터 가까운 순으로
/// 각 날짜의 레벨(여유/보통/혼잡)과 예측치를 카드로 보여준다. 예측 데이터가
/// 없으면 섹션 전체를 감춘다(실시간 아님을 명시).
class CrowdForecastSection extends ConsumerWidget {
  const CrowdForecastSection({super.key, required this.placeId});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(crowdForecastProvider(placeId));
    final forecast = async.value;
    if (forecast == null || !forecast.available) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
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
                  Icons.groups_outlined,
                  size: 20,
                  color: AppColors.softAmber,
                ),
                const SizedBox(width: 10),
                Text(
                  '예측 혼잡도',
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 18),
                ),
                const Spacer(),
                _FreshnessPill(stale: forecast.isStale),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '한국관광공사 예측 · 날짜별 예상 붐빔 정도',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                for (var i = 0; i < forecast.days.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(child: _DayCard(day: forecast.days[i])),
                ],
              ],
            ),
            const SizedBox(height: 14),
            const _LevelLegend(),
            const SizedBox(height: 12),
            Text(
              '실시간 측정값이 아니라 예측입니다. 방문 전 참고용으로 봐 주세요.',
              style: AppTextStyles.labelSm.copyWith(color: AppColors.outline),
            ),
          ],
        ),
      ),
    );
  }
}

Color _levelColor(String level) {
  switch (level) {
    case '혼잡':
    case '붐빔':
      return const Color(0xFFEF6B6B);
    case '보통':
      return AppColors.softAmber;
    case '여유':
      return const Color(0xFF6FCF97);
    default:
      return AppColors.outline;
  }
}

/// yyyy-MM-dd → 오늘/내일/모레 또는 'M/d'.
String _dayLabel(String date) {
  final parsed = DateTime.tryParse(date);
  if (parsed == null) return date;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final d = DateTime(parsed.year, parsed.month, parsed.day);
  final diff = d.difference(today).inDays;
  switch (diff) {
    case 0:
      return '오늘';
    case 1:
      return '내일';
    case 2:
      return '모레';
    default:
      return '${parsed.month}/${parsed.day}';
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({required this.day});

  final DailyCrowd day;

  @override
  Widget build(BuildContext context) {
    final color = _levelColor(day.level);
    final rate = day.score?.round();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        children: [
          Text(
            _dayLabel(day.date),
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Text(
              day.level == 'unknown' ? '정보 없음' : day.level,
              style: AppTextStyles.labelMd.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (rate != null) ...[
            const SizedBox(height: 8),
            Text(
              '$rate%',
              style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface),
            ),
          ],
        ],
      ),
    );
  }
}

class _FreshnessPill extends StatelessWidget {
  const _FreshnessPill({required this.stale});

  final bool stale;

  @override
  Widget build(BuildContext context) {
    final color = stale ? AppColors.outline : AppColors.primary;
    final label = stale ? '데이터 지연' : '예측';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSm.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LevelLegend extends StatelessWidget {
  const _LevelLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _LegendDot(level: '여유'),
        SizedBox(width: 14),
        _LegendDot(level: '보통'),
        SizedBox(width: 14),
        _LegendDot(level: '혼잡'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _levelColor(level),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          level,
          style: AppTextStyles.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
