import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart' show courseDetailProvider;
import 'package:dalbit_suwon/features/course/provider/course_progress_provider.dart' show courseProgressNotifierProvider;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaButton;

class CourseCompletePage extends ConsumerWidget {
  const CourseCompletePage({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(courseDetailProvider(courseId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.onSurface),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Dalbit Suwon'),
        centerTitle: true,
      ),
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.moonlightGold.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.moonlightGold.withOpacity(0.3)),
                ),
                child: const Icon(Icons.star_outline,
                    color: AppColors.moonlightGold, size: 32),
              ),
              const SizedBox(height: 20),
              Text(
                '코스 완주를\n축하합니다!',
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLg.copyWith(
                  color: AppColors.moonlightGold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                detail.title,
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              _CompletionCard(detail: detail),
              const SizedBox(height: 24),
              Text(
                '오늘의 추억을 공유하고 기록해보세요.',
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              MoonlightCtaButton(
                label: '이미지로 저장 및 공유하기',
                icon: Icons.share_outlined,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: '내 기록 확인하기',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _OutlineButton(
                      label: '홈으로 돌아가기',
                      onPressed: () {
                        ref
                            .read(courseProgressNotifierProvider.notifier)
                            .reset();
                        context.go('/');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _LoginNudgeBanner(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionCard extends StatelessWidget {
  const _CompletionCard({required this.detail});
  final detail;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.month}월 ${now.day}일의 밤';

    return Container(
      width: double.infinity,
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
                  detail.heroImageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: AppColors.surfaceContainerHigh,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.surfaceContainer,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COMPLETION RECORD',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.moonlightGold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(dateStr,
                                style: AppTextStyles.headlineMd
                                    .copyWith(fontSize: 18)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.moonlightGold.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    AppColors.moonlightGold.withOpacity(0.3)),
                          ),
                          child: Text('Perfect',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.moonlightGold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.access_time,
                  value:
                      '${detail.estimatedDurationMin ~/ 60}h ${detail.estimatedDurationMin % 60}m',
                  label: '소요 시간',
                ),
                _StatItem(
                  icon: Icons.directions_walk,
                  value: '${detail.walkingDistanceKm}km',
                  label: '이동 거리',
                ),
                _StatItem(
                  icon: Icons.place_outlined,
                  value: '${detail.spots.length}',
                  label: '방문 스팟',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem(
      {required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.onSurfaceVariant, size: 20),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600)),
        Text(label,
            style:
                AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onSurface,
        side: BorderSide(color: AppColors.glassBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(label, style: AppTextStyles.labelMd),
    );
  }
}

class _LoginNudgeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline,
              color: AppColors.onSurfaceVariant, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '기록을 영구적으로 저장하고 싶으신가요?\n로그인하면 언제든 추억을 꺼내볼 수 있습니다.',
              style: AppTextStyles.labelSm
                  .copyWith(color: AppColors.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => context.push('/login'),
            child: Text(
              '로그인/가입',
              style: AppTextStyles.labelMd
                  .copyWith(color: AppColors.moonlightGold),
            ),
          ),
        ],
      ),
    );
  }
}
