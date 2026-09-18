import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show coursesProvider;

/// 추천 데이트 코스 전체 리스트 화면 (2depth).
///
/// 홈 화면 `_SectionHeader(actionLabel: '모두 보기')` 클릭 시 `context.push('/courses')`
/// 로 진입한다. 홈 상단 가로 스크롤 캐러셀과 동일한 [coursesProvider]를 사용하되,
/// 여기서는 세로 스크롤 리스트 형태로 표시해 한눈에 훑어볼 수 있게 한다.
class CoursesListPage extends ConsumerWidget {
  const CoursesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

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
          '추천 데이트 코스',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: coursesAsync.when(
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
        data: (courses) {
          if (courses.isEmpty) {
            return Center(
              child: Text(
                '추천 코스가 없어요',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: courses.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                _CourseListItem(course: courses[index]),
          );
        },
      ),
    );
  }
}

/// 리스트 형식 코스 카드.
///
/// 홈 화면 `_HomeCourseCard`(가로 캐러셀용, 200x220)와 달리 세로 리스트용으로
/// 풀 폭·정보 밀도 높은 레이아웃을 사용한다. 탭 시 코스 상세(`/course/:id`)로 이동.
class _CourseListItem extends StatelessWidget {
  const _CourseListItem({required this.course});
  final CourseSummary course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/course/${course.id}'),
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
                  course.heroImageUrl,
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
                      _StatBadge(
                        icon: Icons.access_time,
                        label: '${course.estimatedDurationMin}분',
                      ),
                      const SizedBox(width: 6),
                      _StatBadge(
                        icon: Icons.place_outlined,
                        label: '${course.spotCount}개 스팟',
                      ),
                      const SizedBox(width: 6),
                      _StatBadge(
                        icon: Icons.directions_walk,
                        label: '${course.walkingDistanceKm}km',
                      ),
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
                    course.title,
                    style: AppTextStyles.headlineMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (course.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      course.subtitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (course.recommendedStartTime.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.nightlight_outlined,
                          size: 14,
                          color: AppColors.softAmber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '추천 시작 ${course.recommendedStartTime}',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.softAmber,
                          ),
                        ),
                      ],
                    ),
                  ],
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
