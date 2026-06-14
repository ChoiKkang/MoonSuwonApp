import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart' show coursesProvider;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
        slivers: [
          _HomeAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                _HeroSection(),
                const SizedBox(height: 32),
                _SectionHeader(title: '추천 데이트 코스', actionLabel: '모두 보기'),
                const SizedBox(height: 16),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: coursesAsync.when(
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(
                  color: AppColors.moonlightGold,
                )),
              ),
              error: (e, _) => Center(child: Text('오류: $e')),
              data: (courses) => _CourseCardList(courses: courses),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionHeader(title: '지금 가기 좋은 스팟'),
                const SizedBox(height: 16),
                _NowGoodSpotRow(),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      ),
      bottomNavigationBar: _HomeBottomNav(),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      floating: true,
      titleSpacing: 20,
      title: Row(
        children: [
          Text(
            'Dalbit Suwon',
            style: AppTextStyles.headlineMd.copyWith(
              color: AppColors.moonlightGold,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Icon(Icons.notifications_outlined,
              color: AppColors.onSurfaceVariant, size: 24),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '수원화성의 밤을 잇는\n가장 로맨틱한 방법',
          style: AppTextStyles.headlineLg.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 8),
        Text(
          '오늘 밤, 당신의 걸음을 안내할게요.',
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel});
  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.headlineMd),
        const Spacer(),
        if (actionLabel != null)
          Text(
            '$actionLabel >',
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _CourseCardList extends StatelessWidget {
  const _CourseCardList({required this.courses});
  final List<CourseSummary> courses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: courses.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            _HomeCourseCard(course: courses[index]),
      ),
    );
  }
}

class _HomeCourseCard extends StatelessWidget {
  const _HomeCourseCard({required this.course});
  final CourseSummary course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/course/${course.id}'),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    course.heroImageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 120,
                      color: AppColors.surfaceContainerHigh,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                course.title,
                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
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
          Text(label,
              style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

class _NowGoodSpotRow extends StatelessWidget {
  final _spots = const [
    ('방화수류정', 'spot-banghwasuryujeong'),
    ('화성행궁', 'spot-hwaseonghaenggung'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _spots
          .map((s) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: s == _spots.last ? 0 : 8),
                  child: GestureDetector(
                    onTap: () => context.push('/spot/${s.$2}'),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(12),
                      child: Text(s.$1,
                          style: AppTextStyles.bodyMd
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _HomeBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(
            icon: Icon(Icons.near_me_outlined), label: '내 주변'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline), label: '찜'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
      ],
    );
  }
}
