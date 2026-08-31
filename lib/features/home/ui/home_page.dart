import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/location/location_provider.dart'
    show locationPermissionProvider;
import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show coursesProvider;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart'
    show nowGoodSpotsProvider;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // 첫 진입 시 위치 권한 요청을 트리거한다.
    // FutureProvider는 최초 read 시점에 evaluate 되므로 결과는 무시해도 무방.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(locationPermissionProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  _SectionHeader(
                    title: '추천 데이트 코스',
                    actionLabel: '모두 보기',
                    onActionTap: () => context.push('/courses'),
                  ),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: coursesAsync.when(
                loading: () => const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.moonlightGold,
                    ),
                  ),
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
                  const _NowGoodSpotSection(),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
      // GNB(하단 네비게이션)는 홈 화면에서 hidden 처리한다.
      // 홈은 콘텐츠 몰입에 집중하고, 다른 탭 접근은 홈 외 화면(마이/찜/내 주변)에서만 노출한다.
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
          Icon(
            Icons.notifications_outlined,
            color: AppColors.onSurfaceVariant,
            size: 24,
          ),
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
  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.headlineMd),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onActionTap,
            child: Padding(
              // 터치 영역 확보 (44pt 이상 권장)
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                '$actionLabel >',
                style: AppTextStyles.labelMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
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
    if (courses.isEmpty) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Text(
            '추천 코스가 없어요',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
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
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.w600,
                ),
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
          Text(
            label,
            style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }
}

class _NowGoodSpotSection extends ConsumerWidget {
  const _NowGoodSpotSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotsAsync = ref.watch(nowGoodSpotsProvider);

    return spotsAsync.when(
      loading: () => const SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
      ),
      error: (e, _) => Center(child: Text('오류: $e')),
      data: (spots) {
        if (spots.isEmpty) {
          return const SizedBox(
            height: 156,
            child: Center(child: Text('지금 가기 좋은 스팟이 없어요')),
          );
        }
        return Row(
          children: [
            for (final spot in spots)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: spot == spots.last ? 0 : 8),
                  child: _NowGoodSpotCard(spot: spot),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NowGoodSpotCard extends StatelessWidget {
  const _NowGoodSpotCard({required this.spot});
  final SpotSummary spot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/spot/${spot.slug}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 156,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.glassBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                spot.heroImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: AppColors.surfaceContainerHigh),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.name,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      spot.reasonLabel,
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (spot.forecastStatus == 'forecast_available' &&
                        spot.crowdLevel != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
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
                      )
                    else if (spot.distanceM != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: _StatBadge(
                          icon: Icons.near_me_outlined,
                          label: '${spot.distanceM!.toStringAsFixed(0)}m',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
