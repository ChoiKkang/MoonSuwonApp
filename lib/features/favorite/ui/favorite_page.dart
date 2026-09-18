import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;
import 'package:dalbit_suwon/features/favorite/provider/favorite_provider.dart'
    show
        favoriteCoursesProvider,
        favoriteRepositoryProvider,
        favoriteSpotsProvider;
import 'package:dalbit_suwon/shared/widgets/app_bottom_nav.dart'
    show AppBottomNav, AppBottomNavTab;

enum _FavoriteTab { course, spot }

/// Bookmarks(찜) 탭 목적지 화면.
///
/// 상단 세그먼트로 코스/스팟 리스트를 전환하고, 비로그인 상태에서는
/// 로컬 저장된 찜을 그대로 노출하며 하단 배너로 로그인 유도 문구를 표시한다.
class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  _FavoriteTab _tab = _FavoriteTab.course;

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(authNotifierProvider);
    final coursesAsync = ref.watch(favoriteCoursesProvider);
    final spotsAsync = ref.watch(favoriteSpotsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('찜', style: AppTextStyles.headlineMd),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _SegmentControl(
              currentTab: _tab,
              onChanged: (t) => setState(() => _tab = t),
            ),
            if (!isLoggedIn) const _LoginSyncBanner(),
            Expanded(
              child: switch (_tab) {
                _FavoriteTab.course => coursesAsync.when(
                  loading: _loadingIndicator,
                  error: (e, _) => _errorBox('$e'),
                  data: (courses) => _CourseList(courses: courses),
                ),
                _FavoriteTab.spot => spotsAsync.when(
                  loading: _loadingIndicator,
                  error: (e, _) => _errorBox('$e'),
                  data: (spots) => _SpotList(spots: spots),
                ),
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(
        currentTab: AppBottomNavTab.bookmarks,
      ),
    );
  }

  Widget _loadingIndicator() => const Center(
    child: CircularProgressIndicator(color: AppColors.moonlightGold),
  );

  Widget _errorBox(String message) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    child: Center(child: Text('오류: $message', style: AppTextStyles.bodyMd)),
  );
}

class _SegmentControl extends StatelessWidget {
  const _SegmentControl({required this.currentTab, required this.onChanged});

  final _FavoriteTab currentTab;
  final ValueChanged<_FavoriteTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          for (final tab in _FavoriteTab.values)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(tab),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(
                    right: tab == _FavoriteTab.values.last ? 0 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: tab == currentTab
                        ? AppColors.surfaceContainerHigh
                        : AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: tab == currentTab
                          ? AppColors.moonlightGold.withValues(alpha: 0.4)
                          : AppColors.glassBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tab == _FavoriteTab.course ? '코스' : '스팟',
                      style: AppTextStyles.labelMd.copyWith(
                        color: tab == currentTab
                            ? AppColors.onSurface
                            : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LoginSyncBanner extends StatelessWidget {
  const _LoginSyncBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.sync, color: AppColors.softAmber, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '로그인하고 기기 간에도 찜을 동기화하세요',
              style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseList extends StatelessWidget {
  const _CourseList({required this.courses});

  final List<FavoriteCourseSummary> courses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) return const _EmptyState(label: '아직 찜한 코스가 없어요');
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: courses.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _CourseCard(course: courses[i]),
    );
  }
}

class _SpotList extends StatelessWidget {
  const _SpotList({required this.spots});

  final List<FavoriteSpotSummary> spots;

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) return const _EmptyState(label: '아직 찜한 스팟이 없어요');
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      itemCount: spots.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _SpotCard(spot: spots[i]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_outline,
          size: 40,
          color: AppColors.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(label, style: AppTextStyles.headlineMd),
        const SizedBox(height: 4),
        Text(
          '홈에서 마음에 드는 장소를 찜해보세요.',
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.go('/'),
          child: const Text('홈으로 이동'),
        ),
      ],
    ),
  );
}

class _CourseCard extends ConsumerWidget {
  const _CourseCard({required this.course});

  final FavoriteCourseSummary course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push('/course/${course.courseId}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                course.heroImageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 96,
                  height: 96,
                  color: AppColors.surfaceContainerHigh,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (course.subtitle != null &&
                      course.subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      course.subtitle!,
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${course.estimatedDurationMin}분 · ${course.spotCount}개 스팟',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.bookmark, color: AppColors.moonlightGold),
              tooltip: '찜 해제',
              onPressed: () async {
                final repo = ref.read(favoriteRepositoryProvider);
                await repo.removeAsync(
                  FavoriteTarget(
                    type: FavoriteTargetType.course,
                    id: course.courseId,
                  ),
                );
                ref.invalidate(favoriteCoursesProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SpotCard extends ConsumerWidget {
  const _SpotCard({required this.spot});

  final FavoriteSpotSummary spot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.push('/spot/${spot.slug}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                spot.heroImageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 96,
                  height: 96,
                  color: AppColors.surfaceContainerHigh,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (spot.nightHighlight != null &&
                      spot.nightHighlight!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      spot.nightHighlight!,
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.redAccent),
              tooltip: '찜 해제',
              onPressed: () async {
                final repo = ref.read(favoriteRepositoryProvider);
                await repo.removeAsync(
                  FavoriteTarget(
                    type: FavoriteTargetType.spot,
                    id: spot.placeId,
                  ),
                );
                ref.invalidate(favoriteSpotsProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
