import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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

// 갤러리에서 고른 원본을 image_picker가 이 최대 크기로 리사이즈해서 돌려준다.
// Supabase Storage의 5MB 상한 안에서 여유 있게 저장하기 위한 값.
const _avatarMaxWidth = 1024.0;
const _avatarMaxHeight = 1024.0;
const _avatarJpegQuality = 85;

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _imagePicker = ImagePicker();

  ProfileDto? _initialProfile;

  /// 서버에 저장된 최신 아바타 URL. 사진을 새로 업로드하면 이 값으로 교체된다.
  String? _remoteAvatarUrl;

  /// 사용자가 이번 편집 세션에서 새로 고른 사진의 바이트. 저장 버튼을 눌러
  /// Storage에 업로드하기 전까지 미리보기용으로만 사용한다.
  Uint8List? _pickedBytes;

  /// 새로 고른 사진의 contentType (`image/jpeg` 등). 업로드 시 사용.
  String? _pickedContentType;

  bool _saving = false;
  bool _picking = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _initFromProfile(ProfileDto profile) {
    if (_initialProfile != null && _initialProfile!.id == profile.id) return;
    _initialProfile = profile;
    _nicknameController.text = profile.nickname ?? '';
    _remoteAvatarUrl = profile.avatarUrl;
  }

  bool _isDirty() {
    final initial = _initialProfile;
    if (initial == null) return false;
    final currentNickname = _nicknameController.text.trim();
    final initialNickname = (initial.nickname ?? '').trim();
    if (currentNickname != initialNickname) return true;
    if ((_remoteAvatarUrl ?? '') != (initial.avatarUrl ?? '')) return true;
    if (_pickedBytes != null) return true;
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

      // 새 사진을 고른 경우 먼저 Storage에 업로드해서 URL을 확보한다.
      var avatarUrl = _remoteAvatarUrl;
      final pickedBytes = _pickedBytes;
      final pickedType = _pickedContentType;
      if (pickedBytes != null && pickedType != null) {
        avatarUrl = await repo.uploadAvatarAsync(
          bytes: pickedBytes,
          contentType: pickedType,
        );
      }

      await repo.updateProfileAsync(
        nickname: _nicknameController.text.trim(),
        avatarUrl: avatarUrl,
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

  Future<void> _onPickAvatarAsync() async {
    if (_picking) return;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.photo_library_outlined,
                color: AppColors.moonlightGold,
              ),
              title: Text('갤러리에서 선택', style: AppTextStyles.bodyMd),
              onTap: () =>
                  Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(
                Icons.photo_camera_outlined,
                color: AppColors.moonlightGold,
              ),
              title: Text('카메라로 촬영', style: AppTextStyles.bodyMd),
              onTap: () =>
                  Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            if (_pickedBytes != null || (_remoteAvatarUrl?.isNotEmpty ?? false))
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                ),
                title: Text(
                  '기본 이미지로 되돌리기',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.error),
                ),
                onTap: () => Navigator.of(sheetContext).pop(null),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (!mounted) return;

    if (source == null) {
      // 시트가 그냥 닫혔거나 "기본 이미지로 되돌리기"를 눌렀을 때.
      // 시트 액션과 dismiss를 구분하지 못하므로, 기본 이미지로 되돌리는 동작은
      // 리모트/픽업된 이미지가 있을 때만 실제로 반영한다.
      if (_pickedBytes != null || (_remoteAvatarUrl?.isNotEmpty ?? false)) {
        setState(() {
          _pickedBytes = null;
          _pickedContentType = null;
          _remoteAvatarUrl = null;
        });
      }
      return;
    }

    setState(() => _picking = true);
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: _avatarMaxWidth,
        maxHeight: _avatarMaxHeight,
        imageQuality: _avatarJpegQuality,
      );
      if (picked == null) return; // 사용자가 취소
      final bytes = await picked.readAsBytes();
      // image_picker는 JPG로 재인코딩해서 돌려주는 것을 기본 동작으로 하지만,
      // 안전을 위해 원본 mime 힌트를 우선 사용하고, 확장자로 폴백한다.
      final mime = picked.mimeType ?? _mimeFromPath(picked.path);
      setState(() {
        _pickedBytes = bytes;
        _pickedContentType = mime;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사진을 불러오지 못했습니다.')),
      );
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  static String _mimeFromPath(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
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
            pickedBytes: _pickedBytes,
            remoteAvatarUrl: _remoteAvatarUrl,
            profile: profile,
            picking: _picking,
            onPickAvatarAsync: _onPickAvatarAsync,
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
    required this.pickedBytes,
    required this.remoteAvatarUrl,
    required this.profile,
    required this.picking,
    required this.onPickAvatarAsync,
    required this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nicknameController;
  final Uint8List? pickedBytes;
  final String? remoteAvatarUrl;
  final ProfileDto profile;
  final bool picking;
  final Future<void> Function() onPickAvatarAsync;
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
                pickedBytes: pickedBytes,
                remoteAvatarUrl: remoteAvatarUrl,
                picking: picking,
                onEditPressed: onPickAvatarAsync,
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
    required this.pickedBytes,
    required this.remoteAvatarUrl,
    required this.picking,
    required this.onEditPressed,
  });
  final Uint8List? pickedBytes;
  final String? remoteAvatarUrl;
  final bool picking;
  final Future<void> Function() onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: onEditPressed,
            child: Stack(
              children: [
                Container(
                  width: 112,
                  height: 112,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.moonlightGold,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(child: _buildAvatarImage()),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.moonlightGold,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                    child: Icon(
                      Icons.photo_camera,
                      size: 16,
                      color: AppColors.background,
                    ),
                  ),
                ),
                if (picking)
                  Positioned.fill(
                    child: ClipOval(
                      child: Container(
                        color: AppColors.background.withValues(alpha: 0.5),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: AppColors.moonlightGold,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: picking ? null : onEditPressed,
            child: Text(
              '사진 변경',
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.moonlightGold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage() {
    if (pickedBytes != null) {
      return Image.memory(pickedBytes!, fit: BoxFit.cover);
    }
    final url = remoteAvatarUrl;
    if (url == null || url.isEmpty) {
      return ColoredBox(
        color: AppColors.surfaceContainerHigh,
        child: const Icon(
          Icons.person,
          color: AppColors.onSurfaceVariant,
          size: 48,
        ),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => ColoredBox(
        color: AppColors.surfaceContainerHigh,
        child: const Icon(
          Icons.person,
          color: AppColors.onSurfaceVariant,
          size: 48,
        ),
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
          Expanded(child: Text(label, style: AppTextStyles.bodyMd)),
          Icon(Icons.verified, size: 18, color: AppColors.moonlightGold),
        ],
      ),
    );
  }
}
