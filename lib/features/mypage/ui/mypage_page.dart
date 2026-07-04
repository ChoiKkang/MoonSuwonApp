import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/provider/mypage_provider.dart'
    show myPageSummaryProvider;
import 'package:dalbit_suwon/shared/widgets/app_bottom_nav.dart'
    show AppBottomNav, AppBottomNavTab;

// Stitch 참고: https://stitch.withgoogle.com/projects/12684725898331039692?node-id=1c36d68a416e4ec288af7a0f9e30c937
const _glassPanelColor = Color(0x661E293B);
const _cardRadius = 12.0;

class MyPagePage extends ConsumerWidget {
  const MyPagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authNotifierProvider);
    final summaryAsync = ref.watch(myPageSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: summaryAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.moonlightGold),
          ),
          error: (e, _) => Center(child: Text('오류: $e')),
          data: (summary) => CustomScrollView(
            slivers: [
              _MyPageAppBar(isLoggedIn: isLoggedIn),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 8),
                    isLoggedIn
                        ? _ProfileCardLoggedIn(summary: summary)
                        : const _ProfileCardGuest(),
                    const SizedBox(height: 32),
                    Text('나의 활동', style: AppTextStyles.headlineMd),
                    const SizedBox(height: 16),
                    if (summary.recentCourse != null) ...[
                      _RecentCourseCard(course: summary.recentCourse!),
                      const SizedBox(height: 16),
                    ],
                    _StatsRow(summary: summary),
                    if (!isLoggedIn) ...[
                      const SizedBox(height: 8),
                      Text(
                        '로그인 시 기기 간 동기화',
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    Text('설정', style: AppTextStyles.headlineMd),
                    const SizedBox(height: 16),
                    _SettingsList(summary: summary, isLoggedIn: isLoggedIn),
                    if (isLoggedIn) ...[
                      const SizedBox(height: 8),
                      _AccountActions(),
                    ],
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentTab: AppBottomNavTab.my),
    );
  }
}

class _MyPageAppBar extends StatelessWidget {
  const _MyPageAppBar({required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      floating: true,
      titleSpacing: 20,
      title: Row(
        children: [
          Text(
            '마이',
            style: AppTextStyles.headlineMd.copyWith(
              color: AppColors.moonlightGold,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (isLoggedIn)
            Icon(Icons.notifications_outlined,
                color: AppColors.onSurfaceVariant, size: 24),
        ],
      ),
    );
  }
}

class _ProfileCardGuest extends StatelessWidget {
  const _ProfileCardGuest();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _glassPanelColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.moonlightGold.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.dark_mode,
              color: AppColors.moonlightGold,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text('나들이객', style: AppTextStyles.headlineMd),
          const SizedBox(height: 4),
          Text(
            '로그인하고 더 많은 혜택을 받아보세요',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => context.push('/login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.moonlightGold,
                foregroundColor: AppColors.background,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_cardRadius),
                ),
              ),
              child: Text(
                '로그인 / 회원가입',
                style: AppTextStyles.labelMd.copyWith(color: AppColors.background),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCardLoggedIn extends StatelessWidget {
  const _ProfileCardLoggedIn({required this.summary});
  final MyPageSummary summary;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_cardRadius),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _glassPanelColor,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.8, -0.8),
                    radius: 0.9,
                    colors: [
                      AppColors.softAmber.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: TextButton(
                onPressed: () => _showComingSoon(context, '프로필 편집'),
                child: Text(
                  '프로필 편집',
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 8),
                _Avatar(avatarUrl: summary.avatarUrl),
                const SizedBox(height: 16),
                Text(summary.nickname, style: AppTextStyles.headlineLg),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, size: 16, color: AppColors.onSurface),
                      const SizedBox(width: 6),
                      Text(
                        summary.loginProviderLabel,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.moonlightGold, width: 2),
      ),
      child: ClipOval(
        child: avatarUrl == null
            ? ColoredBox(
                color: AppColors.surfaceContainerHigh,
                child: const Icon(
                  Icons.person,
                  color: AppColors.onSurfaceVariant,
                  size: 40,
                ),
              )
            : Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: AppColors.surfaceContainerHigh,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.onSurfaceVariant,
                    size: 40,
                  ),
                ),
              ),
      ),
    );
  }
}

class _RecentCourseCard extends StatelessWidget {
  const _RecentCourseCard({required this.course});
  final CourseSummary course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/course/${course.id}/progress'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_cardRadius),
        child: SizedBox(
          height: 192,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                course.heroImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.surfaceContainerHigh,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.background,
                      AppColors.background.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '최근 진행 코스',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.moonlightGold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: AppTextStyles.headlineMd.copyWith(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${course.walkingDistanceKm}km 남음',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.moonlightGold,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.moonlightGold.withValues(alpha: 0.15),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Text(
                            '계속하기',
                            style: AppTextStyles.labelMd.copyWith(
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ],
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

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.summary});
  final MyPageSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.location_on,
            iconColor: AppColors.softAmber,
            label: '찜한 장소',
            value: '${summary.favoriteSpotCount}',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.route,
            iconColor: AppColors.moonlightGold,
            label: '찜한 코스',
            value: '${summary.favoriteCourseCount}',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _glassPanelColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(value, style: AppTextStyles.headlineMd),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.summary, required this.isLoggedIn});
  final MyPageSummary summary;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _glassPanelColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.glassBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _SettingsTile(
            title: '위치 권한 설정',
            trailing: isLoggedIn
                ? null
                : _StatusPill(
                    label: summary.locationPermissionGranted ? '허용됨' : '미설정',
                  ),
            onTap: () => _showComingSoon(context, '위치 권한 설정'),
          ),
          const Divider(height: 1, color: AppColors.glassBorder),
          _SettingsTile(
            title: '알림 설정',
            onTap: () => _showComingSoon(context, '알림 설정'),
          ),
          const Divider(height: 1, color: AppColors.glassBorder),
          _SettingsTile(
            title: '버전 정보',
            trailing: Text(
              summary.appVersion,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            showChevron: false,
          ),
          const Divider(height: 1, color: AppColors.glassBorder),
          _SettingsTile(
            title: '자주 묻는 질문',
            onTap: () => _showComingSoon(context, '자주 묻는 질문'),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    this.trailing,
    this.showChevron = true,
    this.onTap,
  });

  final String title;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.bodyMd),
            ),
            if (trailing != null) trailing!,
            if (onTap != null && showChevron)
              Icon(Icons.chevron_right, size: 20, color: AppColors.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _AccountActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => _confirmLogoutAsync(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.centerLeft,
          ),
          child: Text(
            '로그아웃',
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ),
        TextButton(
          onPressed: () => _confirmWithdrawAsync(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.centerLeft,
          ),
          child: Text(
            '회원탈퇴',
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}

void _showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$feature 기능은 준비 중입니다.')),
  );
}

Future<void> _confirmLogoutAsync(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.surfaceContainer,
      title: const Text('로그아웃'),
      content: const Text('정말 로그아웃 하시겠어요?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('로그아웃'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;
  await ProviderScope.containerOf(context)
      .read(authNotifierProvider.notifier)
      .logoutAsync();
}

Future<void> _confirmWithdrawAsync(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.surfaceContainer,
      title: const Text('회원탈퇴'),
      content: const Text('회원탈퇴 시 모든 기록이 삭제되며 복구할 수 없습니다. 계속할까요?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text('탈퇴', style: TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  final notifier = ProviderScope.containerOf(context).read(authNotifierProvider.notifier);
  try {
    await notifier.deleteAccountAsync();
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원탈퇴에 실패했습니다. 잠시 후 다시 시도해 주세요.')),
      );
    }
  }
}
