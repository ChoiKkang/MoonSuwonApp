import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CourseHistoryEntryDto;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseRepositoryProvider;

part 'course_history_page.g.dart';

/// 마이페이지 "나의 활동 > 내 기록보기 >" 클릭 시 진입하는 2depth 화면.
///
/// `public.list_user_course_history` RPC를 통해 로그인 사용자의 코스 진행/완료
/// 이력을 최신순 20건까지 조회하고, 진행 상태별로 라벨과 CTA를 다르게 표시한다.
///
/// 비로그인 사용자는 서버 RPC가 빈 결과를 반환하므로 빈 상태 UI를 보여준다.
class CourseHistoryPage extends ConsumerWidget {
  const CourseHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authNotifierProvider);
    final historyAsync = ref.watch(userCourseHistoryProvider);

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
          '내 기록',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: !isLoggedIn
          ? const _GuestEmptyView()
          : historyAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.moonlightGold,
                ),
              ),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    '기록을 불러오지 못했어요\n$e',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return const _EmptyHistoryView();
                }
                return RefreshIndicator(
                  color: AppColors.moonlightGold,
                  backgroundColor: AppColors.surfaceContainer,
                  onRefresh: () async {
                    ref.invalidate(userCourseHistoryProvider);
                    await ref.read(userCourseHistoryProvider.future);
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        _HistoryItem(entry: list[index]),
                  ),
                );
              },
            ),
    );
  }
}

/// list_user_course_history RPC 결과 provider (최신순 20건).
@riverpod
Future<List<CourseHistoryEntryDto>> userCourseHistory(Ref ref) {
  // 로그인/로그아웃 상태 변경 시 재조회.
  ref.watch(authNotifierProvider);
  return ref
      .read(courseRepositoryProvider)
      .listUserCourseHistoryAsync(limit: 20);
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.entry});
  final CourseHistoryEntryDto entry;

  String get _statusLabel {
    switch (entry.status) {
      case 'completed':
        return '완주';
      case 'abandoned':
        return '중단';
      case 'in_progress':
      default:
        return '진행 중';
    }
  }

  Color get _statusColor {
    switch (entry.status) {
      case 'completed':
        return AppColors.moonlightGold;
      case 'abandoned':
        return AppColors.onSurfaceVariant;
      case 'in_progress':
      default:
        return AppColors.softAmber;
    }
  }

  String get _progressLabel {
    if (entry.spotCount <= 0) return '';
    return '${entry.checkinCount}/${entry.spotCount} 스팟';
  }

  /// 진행 상태별 화면 이동 경로.
  String get _targetPath {
    switch (entry.status) {
      case 'completed':
        return '/course/${entry.courseId}/complete';
      case 'in_progress':
        return '/course/${entry.courseId}/progress';
      case 'abandoned':
      default:
        return '/course/${entry.courseId}';
    }
  }

  String get _dateLabel {
    // 완료 시각이 있으면 그 날짜, 없으면 시작 시각으로 표시.
    final ref = entry.completedAt ?? entry.startedAt;
    if (ref == null) return '';
    final y = ref.year.toString().padLeft(4, '0');
    final m = ref.month.toString().padLeft(2, '0');
    final d = ref.day.toString().padLeft(2, '0');
    return '$y.$m.$d';
  }

  @override
  Widget build(BuildContext context) {
    final heroImageUrl = entry.heroImageUrl;
    final dateLabel = _dateLabel;
    final progressLabel = _progressLabel;

    return GestureDetector(
      onTap: () => context.push(_targetPath),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: (heroImageUrl == null || heroImageUrl.isEmpty)
                  ? Container(color: AppColors.surfaceContainerHigh)
                  : Image.network(
                      heroImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: AppColors.surfaceContainerHigh),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _statusColor.withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            _statusLabel,
                            style: AppTextStyles.labelSm.copyWith(
                              color: _statusColor,
                            ),
                          ),
                        ),
                        if (dateLabel.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            dateLabel,
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.heroTitle.isEmpty ? '진행한 코스' : entry.heroTitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (progressLabel.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        progressLabel,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history,
              size: 42,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text('아직 진행한 코스가 없어요', style: AppTextStyles.bodyMd),
            const SizedBox(height: 4),
            Text(
              '홈에서 추천 코스를 골라 오늘의 밤을 시작해보세요.',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestEmptyView extends StatelessWidget {
  const _GuestEmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 42,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text('로그인이 필요합니다', style: AppTextStyles.bodyMd),
            const SizedBox(height: 4),
            Text(
              '기기 간 동기화된 코스 기록은 로그인 후 확인할 수 있어요.',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => context.push('/login'),
              child: const Text('로그인 / 회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
