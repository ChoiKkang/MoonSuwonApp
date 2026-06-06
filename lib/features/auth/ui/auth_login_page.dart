import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart' show authNotifierProvider;

class AuthLoginPage extends ConsumerStatefulWidget {
  const AuthLoginPage({super.key});

  @override
  ConsumerState<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends ConsumerState<AuthLoginPage> {
  bool loading = false;

  Future<void> _onLoginWithKakaoAsync() async {
    setState(() => loading = true);
    await ref.read(authNotifierProvider.notifier).loginWithKakaoAsync();
    if (mounted) {
      setState(() => loading = false);
      context.pop();
    }
  }

  Future<void> _onLoginWithNaverAsync() async {
    setState(() => loading = true);
    await ref.read(authNotifierProvider.notifier).loginWithNaverAsync();
    if (mounted) {
      setState(() => loading = false);
      context.pop();
    }
  }

  Future<void> _onLoginWithAppleAsync() async {
    setState(() => loading = true);
    await ref.read(authNotifierProvider.notifier).loginWithAppleAsync();
    if (mounted) {
      setState(() => loading = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: const Icon(
                  Icons.nightlight_round,
                  color: AppColors.moonlightGold,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Dalbit Suwon',
                style: AppTextStyles.headlineLg.copyWith(
                  color: AppColors.moonlightGold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '수원의 밤, 당신의 추억을 저장하세요',
                style: AppTextStyles.bodyMd
                    .copyWith(color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              _SocialLoginButton(
                label: '카카오로 시작하기',
                backgroundColor: const Color(0xFFFEE500),
                foregroundColor: const Color(0xFF191919),
                icon: Icons.chat_bubble_rounded,
                onPressed: loading ? null : _onLoginWithKakaoAsync,
              ),
              const SizedBox(height: 12),
              _SocialLoginButton(
                label: '네이버로 시작하기',
                backgroundColor: const Color(0xFF03C75A),
                foregroundColor: Colors.white,
                icon: Icons.grid_view_rounded,
                onPressed: loading ? null : _onLoginWithNaverAsync,
              ),
              const SizedBox(height: 12),
              _SocialLoginButton(
                label: 'Apple로 시작하기',
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                icon: Icons.apple,
                onPressed: loading ? null : _onLoginWithAppleAsync,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  '로그인 없이 둘러보기',
                  style: AppTextStyles.labelMd
                      .copyWith(color: AppColors.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '로그인 시 서비스 이용 약관 및 개인정보처리방침에 동의하게 됩니다.',
                style: AppTextStyles.labelSm
                    .copyWith(color: AppColors.outline),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.onPressed,
  });
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.labelMd.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
