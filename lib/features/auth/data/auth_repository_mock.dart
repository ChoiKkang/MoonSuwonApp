import 'dart:convert';
import 'dart:typed_data';

import 'package:dalbit_suwon/features/auth/data/auth_repository.dart'
    show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto;

class AuthRepositoryMock implements AuthRepository {
  bool _loggedIn = false;
  String? _nickname = '수원달빛러';
  String? _avatarUrl;

  @override
  bool get isLoggedIn => _loggedIn;

  @override
  Future<void> loginWithKakaoAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _loggedIn = true;
  }

  @override
  Future<void> loginWithAppleAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _loggedIn = true;
  }

  @override
  Future<void> logoutAsync() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _loggedIn = false;
  }

  @override
  Future<void> deleteAccountAsync() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _loggedIn = false;
  }

  @override
  Future<ProfileDto?> fetchCurrentProfileAsync() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!_loggedIn) return null;
    return ProfileDto(
      id: 'mock-user-id',
      nickname: _nickname,
      avatarUrl: _avatarUrl,
      provider: 'apple',
      providerSub: 'mock-sub',
      isPrivateEmail: false,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<ProfileDto> updateProfileAsync({
    required String nickname,
    String? avatarUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!_loggedIn) {
      throw StateError('로그인이 필요합니다.');
    }
    final trimmedNickname = nickname.trim();
    if (trimmedNickname.isEmpty) {
      throw ArgumentError.value(nickname, 'nickname', '닉네임은 공백일 수 없습니다.');
    }
    _nickname = trimmedNickname;
    final trimmedAvatar = avatarUrl?.trim();
    _avatarUrl = (trimmedAvatar == null || trimmedAvatar.isEmpty)
        ? null
        : trimmedAvatar;

    return ProfileDto(
      id: 'mock-user-id',
      nickname: _nickname,
      avatarUrl: _avatarUrl,
      provider: 'apple',
      providerSub: 'mock-sub',
      isPrivateEmail: false,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<String> uploadAvatarAsync({
    required Uint8List bytes,
    required String contentType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!_loggedIn) {
      throw StateError('로그인이 필요합니다.');
    }
    // Mock 구현은 실제 Storage 없이도 미리보기와 프로필 저장 흐름을 검증할 수 있도록
    // data URL을 반환한다. 프로덕션에서는 Supabase Storage가 공개 URL을 돌려준다.
    final base64 = base64Encode(bytes);
    return 'data:$contentType;base64,$base64';
  }
}
