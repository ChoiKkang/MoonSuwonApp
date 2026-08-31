import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart' show courseDetailProvider;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/ui/widgets/favorite_toggle_button.dart'
    show FavoriteToggleButton;
import 'package:dalbit_suwon/shared/widgets/glass_icon_button.dart' show GlassIconButton;
import 'package:dalbit_suwon/shared/widgets/hero_image_header.dart' show HeroImageHeader;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaBar;

class CourseDetailPage extends ConsumerWidget {
  const CourseDetailPage({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(courseDetailProvider(courseId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (detail) => _CourseDetailContent(detail: detail, courseId: courseId),
      ),
    );
  }
}

class _CourseDetailContent extends StatelessWidget {
  const _CourseDetailContent({required this.detail, required this.courseId});
  final CourseDetail detail;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  HeroImageHeader(imageUrl: detail.heroImageUrl, height: 360),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlassIconButton(
                          icon: Icons.arrow_back,
                          onPressed: () => context.pop(),
                        ),
                        FavoriteToggleButton.course(
                          course: FavoriteCourseSummary(
                            courseId: detail.id,
                            slug: courseId,
                            title: detail.title,
                            subtitle: detail.subtitle,
                            routeSummary: detail.description,
                            estimatedDurationMin: detail.estimatedDurationMin,
                            spotCount: detail.spots.length,
                            heroImageUrl: detail.heroImageUrl,
                            themeTags: detail.themeTags,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top, 20, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _CourseHeader(detail: detail),
                  const SizedBox(height: 32),
                  Text('코스 안내', style: AppTextStyles.headlineMd),
                  const SizedBox(height: 16),
                  ...detail.spots.asMap().entries.map(
                    (e) => _CourseSpotTimelineItem(
                      spot: e.value,
                      index: e.key,
                      isLast: e.key == detail.spots.length - 1,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: MoonlightCtaBar(
            label: '코스 시작하기',
            icon: Icons.play_arrow_rounded,
            onPressed: () =>
                context.push('/course/${detail.id}/progress'),
          ),
        ),
      ],
    );
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader({required this.detail});
  final CourseDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.camera_alt_outlined,
                  size: 14, color: AppColors.softAmber),
              const SizedBox(width: 6),
              Text('사진 명소',
                  style: AppTextStyles.labelSm
                      .copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(detail.title, style: AppTextStyles.headlineLg),
        const SizedBox(height: 16),
        Row(
          children: [
            _InfoChip(
              icon: Icons.access_time,
              label: '${detail.estimatedDurationMin}분',
            ),
            const SizedBox(width: 8),
            _InfoChip(
              icon: Icons.directions_walk,
              label: '${detail.walkingDistanceKm}km',
            ),
            const SizedBox(width: 8),
            _InfoChip(
              icon: Icons.schedule,
              label: '${detail.recommendedStartTime} 권장',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          detail.description,
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(label,
            style: AppTextStyles.labelSm
                .copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}

class _CourseSpotTimelineItem extends StatelessWidget {
  const _CourseSpotTimelineItem({
    required this.spot,
    required this.index,
    required this.isLast,
  });
  final Spot spot;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.moonlightGold,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppTextStyles.labelSm.copyWith(
                        color: const Color(0xFF283044),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: AppColors.outlineVariant,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spot.name, style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
                    const SizedBox(height: 4),
                    Text(spot.summary,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
