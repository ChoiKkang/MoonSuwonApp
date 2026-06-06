import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot, SpotProgressStatus;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart' show courseDetailProvider;
import 'package:dalbit_suwon/features/course/provider/course_progress_provider.dart'
    show courseProgressNotifierProvider, arrivalModalNotifierProvider, statusForIndex;
import 'package:dalbit_suwon/shared/widgets/arrival_modal.dart' show ArrivalModal;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaBar;

class CourseProgressPage extends ConsumerWidget {
  const CourseProgressPage({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(courseDetailProvider(courseId));
    final currentIndex = ref.watch(courseProgressNotifierProvider);
    final showModal = ref.watch(arrivalModalNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: const Text('코스 진행 현황'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (detail) {
          final spots = detail.spots;
          final isCompleted = currentIndex >= spots.length;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Text(
                          'PHOTO FOCUS COURSE',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.moonlightGold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(detail.title, style: AppTextStyles.headlineLg),
                        const SizedBox(height: 8),
                        Text(
                          detail.description,
                          style: AppTextStyles.bodyMd
                              .copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 32),
                        ...spots.asMap().entries.map((e) =>
                            _ProgressSpotItem(
                              spot: e.value,
                              status: statusForIndex(currentIndex, e.key),
                              isLast: e.key == spots.length - 1,
                            )),
                      ]),
                    ),
                  ),
                ],
              ),
              if (!showModal)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: isCompleted
                      ? MoonlightCtaBar(
                          label: '코스 완료!',
                          icon: Icons.check_circle_outline,
                          onPressed: () =>
                              context.go('/course/$courseId/complete'),
                        )
                      : MoonlightCtaBar(
                          label: '미션으로 돌아가기',
                          icon: Icons.my_location,
                          onPressed: () => ref
                              .read(arrivalModalNotifierProvider.notifier)
                              .show(),
                        ),
                ),
              if (showModal)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => ref
                        .read(arrivalModalNotifierProvider.notifier)
                        .hide(),
                    child: Container(color: Colors.black54),
                  ),
                ),
              if (showModal && !isCompleted)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ArrivalModal(
                    spotName: spots[currentIndex].name,
                    currentIndex: currentIndex + 1,
                    totalCount: spots.length,
                    missionPrompt: spots[currentIndex].missionPrompt,
                    onMissionTap: () {
                      ref.read(arrivalModalNotifierProvider.notifier).hide();
                      context.push('/spot/${spots[currentIndex].id}');
                    },
                    onNextSpotTap: () {
                      ref.read(courseProgressNotifierProvider.notifier)
                          .completeCurrentSpot();
                      ref.read(arrivalModalNotifierProvider.notifier).hide();
                    },
                    onDismiss: () =>
                        ref.read(arrivalModalNotifierProvider.notifier).hide(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressSpotItem extends StatelessWidget {
  const _ProgressSpotItem({
    required this.spot,
    required this.status,
    required this.isLast,
  });
  final Spot spot;
  final SpotProgressStatus status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isCurrent = status == SpotProgressStatus.current;
    final isCompleted = status == SpotProgressStatus.completed;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.moonlightGold
                        : isCurrent
                            ? AppColors.softAmber
                            : AppColors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                    border: isCurrent
                        ? Border.all(color: AppColors.softAmber, width: 2)
                        : null,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : isCurrent
                            ? Icons.camera_alt_outlined
                            : null,
                    size: 14,
                    color: isCompleted
                        ? const Color(0xFF283044)
                        : AppColors.onSurface,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: isCompleted
                          ? AppColors.moonlightGold.withOpacity(0.4)
                          : AppColors.outlineVariant,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppColors.surfaceContainerHigh
                      : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCurrent
                        ? AppColors.softAmber.withOpacity(0.3)
                        : AppColors.glassBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: AppColors.softAmber.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('현재 장소',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.softAmber,
                                )),
                          ),
                        const Spacer(),
                        if (isCompleted)
                          Text('완료',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.moonlightGold,
                              ))
                        else if (!isCurrent)
                          Text('예정',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                              )),
                      ],
                    ),
                    Text(spot.name,
                        style: AppTextStyles.bodyMd
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(spot.summary,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        )),
                    if (isCurrent) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.softAmber.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.softAmber.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 14, color: AppColors.softAmber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '촬영 미션: ${spot.missionPrompt}',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.softAmber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
