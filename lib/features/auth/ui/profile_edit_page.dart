import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto, isApplePrivateRelayEmail;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authRepositoryProvider, currentProfileProvider;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart'
    show MoonlightCtaButton;

// Stitch 참고: https://stitch.withgoogle.com/projects/12684725898331039692/screens/d0ac55663abc4ac1a4e3faa769ab377b
// (Stitch는 로그인 필요한 SPA로 공개 접근 불가. mypage_page.dart의 glass 톤과
//  MVP 문서(nickname/avatar_url만 편집 가능)을 근거로 구성)
const _glassPanelColor = Color(0x661E293B);
const _cardRadius = 12.0;
const _nicknameMaxLen = 30;
const _nicknameMinLen = 1;

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();

  ProfileDto? _initialProfile;
  String? _avatarUrl;
  bool _saving = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _initFromProfile(ProfileDto profile) {
    if (_initialProfile != null && _initialProfile!.id == profile.id) return;
    _initialProfile = profile;
    _nicknameController.text = profile.nickname ?? '';
    _avatarUrl = profile.avatarUrl;
  }

  bool _isDirty() {
    final initial = _initialProfile;
    if (initial == null) return false;
    final currentNickname = _nicknameController.text.trim();
    final initialNickname = (initial.nickname ?? '').trim();
    if (currentNickname != initialNickname) return true;
    if ((_avatarUrl ?? '') != (initial.avatarUrl ?? '')) return true;
    return false;
  }

  Future<void> _onSaveAsync() async {
    if (_saving) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.updateProfileAsync(
        nickname: _nicknameController.text.trim(),
        avatarUrl: _avatarUrl,
      );
      ref.invalidate(currentProfileProvider);
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('프로필을 저장했습니다.')),
      );
      router.pop();
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('저장에 실패했습니다. 잠시 후 다시 시도해 주세요.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _onEditAvatarUrlAsync() async {
    final controller = TextEditingController(text: _avatarUrl ?? '');
    final result = await showDialog<String?>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: Text('프로필 이미지 URL', style: AppTextStyles.headlineMd),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.url,
              maxLines: 1,
              autofocus: true,
              style: AppTextStyles.bodyMd,
              decoration: InputDecoration(
                hintText: 'https://example.com/avatar.png',
                hintStyle: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_cardRadius),
                  borderSide: BorderSide(color: AppColors.glassBorder),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '비워두면 기본 이미지가 표시됩니다.',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(null),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 빈 문자열은 '기본 이미지로 초기화'로 취급.
              Navigator.of(dialogContext).pop(controller.text.trim());
            },
            child: Text(
              '확인',
              style: TextStyle(color: AppColors.moonlightGold),
            ),
          ),
        ],
      ),
    );
    if (result == null) return;
    setState(() {
      _avatarUrl = result.isEmpty ? null : result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('프로필 편집', style: AppTextStyles.headlineMd),
        centerTitle: true,
      ),
      body: profileAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              '프로필을 불러오지 못했습니다.',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  '로그인이 필요합니다.',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          _initFromProfile(profile);
          return _ProfileEditBody(
            formKey: _formKey,
            nicknameController: _nicknameController,
            avatarUrl: _avatarUrl,
            profile: profile,
            onEditAvatarUrlAsync: _onEditAvatarUrlAsync,
            onChanged: () => setState(() {}),
          );
        },
      ),
      bottomNavigationBar: profileAsync.maybeWhen(
        data: (profile) {
          if (profile == null) return null;
          final isDirty = _isDirty();
          return MoonlightCtaButton(
            label: '저장',
            onPressed: (_saving || !isDirty) ? null : _onSaveAsync,
            loading: _saving,
          );
        },
        orElse: () => null,
      ),
    );
  }
}

class _ProfileEditBody extends StatelessWidget {
  const _ProfileEditBody({
    required this.formKey,
    required this.nicknameController,
    required this.avatarUrl,
    required this.profile,
    required this.onEditAvatarUrlAsync,
    required this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nicknameController;
  final String? avatarUrl;
  final ProfileDto profile;
  final Future<void> Function() onEditAvatarUrlAsync;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AvatarSection(
                avatarUrl: avatarUrl,
                onEditPressed: onEditAvatarUrlAsync,
              ),
              const SizedBox(height: 32),
              _SectionLabel('닉네임'),
              const SizedBox(height: 8),
              _NicknameField(
                controller: nicknameController,
                onChanged: onChanged,
              ),
              const SizedBox(height: 8),
              Text(
                '1~30자 이내로 입력해 주세요.',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              _SectionLabel('이메일'),
              const SizedBox(height: 8),
              _ReadonlyField(
                value: profile.email ?? '이메일이 등록되어 있지 않습니다.',
                muted: profile.email == null,
              ),
              if (isApplePrivateRelayEmail(profile.email)) ...[
                const SizedBox(height: 8),
                Text(
                  'Apple 비공개 이메일(relay 주소)입니다. 실제 주소는 표시되지 않습니다.',
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ] else if (profile.email != null) ...[
                const SizedBox(height: 8),
                Text(
                  '이메일은 로그인 계정에서 관리되며 앱에서는 변경할 수 없습니다.',
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              _SectionLabel('로그인 방식'),
              const SizedBox(height: 8),
              _ProviderBadge(provider: profile.provider),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.labelMd.copyWith(
        color: AppColors.onSurfaceVariant,
        letterSpacing: 0,
      ),
    );
  }
}

class _AvatarSection extends StatelessWidget {
  const _AvatarSection({
    required this.avatarUrl,
    required this.onEditPressed,
  });
  final String? avatarUrl;
  final Future<void> Function() onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 112,
            height: 112,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.moonlightGold, width: 2),
            ),
            child: ClipOval(
              child: (avatarUrl == null || avatarUrl!.isEmpty)
                  ? ColoredBox(
                      color: AppColors.surfaceContainerHigh,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.onSurfaceVariant,
                        size: 48,
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
                          size: 48,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onEditPressed,
            icon: Icon(Icons.link, size: 16, color: AppColors.moonlightGold),
            label: Text(
              '이미지 URL 변경',
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.moonlightGold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.glassBorder),
              backgroundColor: _glassPanelColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _NicknameField extends StatelessWidget {
  const _NicknameField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (_) => onChanged(),
      textInputAction: TextInputAction.done,
      maxLength: _nicknameMaxLen,
      inputFormatters: [
        LengthLimitingTextInputFormatter(_nicknameMaxLen),
      ],
      style: AppTextStyles.bodyMd,
      cursorColor: AppColors.moonlightGold,
      decoration: InputDecoration(
        hintText: '닉네임을 입력해 주세요',
        hintStyle: AppTextStyles.bodyMd.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        filled: true,
        fillColor: _glassPanelColor,
        counterText: '',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          borderSide: BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          borderSide:
              BorderSide(color: AppColors.moonlightGold.withValues(alpha: 0.5)),
        ),
        errorStyle: AppTextStyles.labelSm.copyWith(color: AppColors.error),
      ),
      validator: (value) {
        final trimmed = value?.trim() ?? '';
        if (trimmed.length < _nicknameMinLen) {
          return '닉네임을 입력해 주세요.';
        }
        if (trimmed.length > _nicknameMaxLen) {
          return '닉네임은 최대 $_nicknameMaxLen자까지 입력할 수 있습니다.';
        }
        return null;
      },
    );
  }
}

class _ReadonlyField extends StatelessWidget {
  const _ReadonlyField({required this.value, this.muted = false});
  final String value;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _glassPanelColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        value,
        style: AppTextStyles.bodyMd.copyWith(
          color: muted ? AppColors.onSurfaceVariant : AppColors.onSurface,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ProviderBadge extends StatelessWidget {
  const _ProviderBadge({required this.provider});
  final String provider;

  @override
  Widget build(BuildContext context) {
    final label = switch (provider) {
      'apple' => 'Apple로 로그인',
      'kakao' => '카카오로 로그인',
      'naver' => '네이버로 로그인',
      _ => '$provider로 로그인',
    };
    final icon = switch (provider) {
      'apple' => Icons.apple,
      'kakao' => Icons.chat_bubble,
      _ => Icons.person,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _glassPanelColor,
        borderRadius: BorderRadius.circular(_cardRadius),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.onSurface),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AppTextStyles.bodyMd),
          ),
          Icon(Icons.verified, size: 18, color: AppColors.moonlightGold),
        ],
      ),
    );
  }
}
