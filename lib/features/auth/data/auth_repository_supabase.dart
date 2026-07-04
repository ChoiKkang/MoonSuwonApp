import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/core/logger/app_logger.dart' show AppLogger;
import 'package:dalbit_suwon/features/auth/data/auth_exceptions.dart'
    show EmailAlreadyInUseException;
import 'package:dalbit_suwon/features/auth/data/auth_repository.dart'
    show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto, isApplePrivateRelayEmail;

class AuthRepositorySupabase implements AuthRepository {
  final _client = Supabase.instance.client;

  @override
  bool get isLoggedIn => _client.auth.currentSession != null;

  @override
  Future<void> loginWithKakaoAsync() async {
    AppLogger.auth('카카오 로그인 시작');
    final isInstalled = await kakao.isKakaoTalkInstalled();
    AppLogger.auth('카카오톡 설치 여부', data: isInstalled);

    final kakao.OAuthToken token = isInstalled
        ? await kakao.UserApi.instance.loginWithKakaoTalk()
        : await kakao.UserApi.instance.loginWithKakaoAccount();

    final idToken = token.idToken;
    if (idToken == null) {
      AppLogger.error('Kakao OIDC idToken 없음 — OpenID Connect 활성화 필요');
      throw Exception(
        'Kakao OIDC가 비활성화되어 있습니다. '
        '카카오 개발자 콘솔 → 카카오 로그인 → OpenID Connect를 활성화해주세요.',
      );
    }

    AppLogger.auth('Supabase signInWithIdToken 요청');
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.kakao,
      idToken: idToken,
    );
    AppLogger.auth('Supabase 로그인 성공', data: _client.auth.currentUser?.id);

    String? kakaoEmail;
    try {
      var kakaoUser = await kakao.UserApi.instance.me();
      if (kakaoUser.kakaoAccount?.emailNeedsAgreement == true) {
        AppLogger.auth('이메일 추가 동의 요청');
        await kakao.UserApi.instance.loginWithNewScopes(['account_email']);
        kakaoUser = await kakao.UserApi.instance.me();
      }
      kakaoEmail = kakaoUser.kakaoAccount?.email;
      AppLogger.auth('카카오 이메일 조회', data: kakaoEmail ?? 'null');
    } catch (e, st) {
      AppLogger.error('카카오 me() 이메일 조회 실패', error: e, stackTrace: st);
    }
    EmailAlreadyInUseException? emailConflict;
    try {
      await _updateAuthEmailAsync(kakaoEmail);
    } on EmailAlreadyInUseException catch (e) {
      emailConflict = e;
    }
    await _upsertProfileAsync(provider: 'kakao', providerEmail: kakaoEmail);
    if (emailConflict != null) throw emailConflict;
  }

  @override
  Future<void> loginWithNaverAsync() async {
    throw UnimplementedError('네이버 로그인은 준비 중입니다.');
  }

  @override
  Future<void> loginWithAppleAsync() async {
    AppLogger.auth('Apple 로그인 시작');
    final isAvailable = await SignInWithApple.isAvailable();
    if (!isAvailable) {
      throw const AuthException('Apple 로그인은 이 기기에서 사용할 수 없습니다.');
    }

    final rawNonce = _client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException('Apple identityToken을 찾을 수 없습니다.');
    }

    AppLogger.auth('Supabase Apple signInWithIdToken 요청');
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
    AppLogger.auth('Supabase Apple 로그인 성공', data: _client.auth.currentUser?.id);

    final appleEmail = credential.email;
    EmailAlreadyInUseException? emailConflict;
    try {
      await _updateAuthEmailAsync(appleEmail);
    } on EmailAlreadyInUseException catch (e) {
      emailConflict = e;
    }
    await _upsertProfileAsync(
      provider: 'apple',
      providerEmail: appleEmail,
      providerNickname: _fullNameFromAppleCredential(credential),
    );
    if (emailConflict != null) throw emailConflict;
  }

  @override
  Future<void> logoutAsync() async {
    try {
      await kakao.UserApi.instance.logout();
    } catch (_) {}
    await _client.auth.signOut();
  }

  @override
  Future<void> deleteAccountAsync() async {
    AppLogger.auth('회원탈퇴 요청');
    try {
      await _client.rpc('delete_own_account');
    } catch (e, st) {
      AppLogger.error('회원탈퇴 실패', error: e, stackTrace: st);
      rethrow;
    }
    AppLogger.auth('회원탈퇴 완료');

    try {
      await kakao.UserApi.instance.logout();
    } catch (_) {}
    await _client.auth.signOut();
  }

  @override
  Future<ProfileDto?> fetchCurrentProfileAsync() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    try {
      final row = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      if (row == null) return null;
      return ProfileDto.fromJson(row);
    } catch (e, st) {
      AppLogger.error('프로필 조회 실패', error: e, stackTrace: st);
      return null;
    }
  }

  Future<void> _updateAuthEmailAsync(String? email) async {
    if (email == null || email.isEmpty) return;
    final currentEmail = _client.auth.currentUser?.email;
    if (currentEmail != null && currentEmail.isNotEmpty) return;
    try {
      await _client.auth.updateUser(UserAttributes(email: email));
      AppLogger.auth('auth.users 이메일 업데이트 완료', data: email);
    } on AuthException catch (e, st) {
      AppLogger.error('auth.users 이메일 중복 감지', error: e, stackTrace: st);
      throw const EmailAlreadyInUseException();
    } catch (e, st) {
      AppLogger.error(
        'auth.users 이메일 업데이트 실패 (로그인은 계속)',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _upsertProfileAsync({
    required String provider,
    String? providerEmail,
    String? providerNickname,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final metadata = user.userMetadata ?? {};
    String? nonEmpty(String? v) => (v != null && v.isNotEmpty) ? v : null;
    final profileEmail =
        nonEmpty(user.email) ??
        nonEmpty(providerEmail) ??
        nonEmpty(metadata['email'] as String?);
    final dto = ProfileDto(
      id: user.id,
      email: profileEmail,
      nickname:
          nonEmpty(providerNickname) ??
          (metadata['name'] as String?) ??
          (metadata['full_name'] as String?) ??
          (metadata['user_name'] as String?),
      avatarUrl:
          (metadata['avatar_url'] as String?) ??
          (metadata['picture'] as String?),
      provider: provider,
      providerSub: _providerSubject(user: user, provider: provider),
      isPrivateEmail:
          provider == 'apple' && isApplePrivateRelayEmail(profileEmail),
      updatedAt: DateTime.now(),
    );

    AppLogger.network('profiles upsert 요청', data: dto.toJson());
    try {
      await _client.from('profiles').upsert(dto.toJson());
      AppLogger.network('profiles upsert 완료');
    } catch (e, st) {
      AppLogger.error('profiles upsert 실패', error: e, stackTrace: st);
      rethrow;
    }
  }

  String? _fullNameFromAppleCredential(
    AuthorizationCredentialAppleID credential,
  ) {
    final parts = [
      credential.givenName,
      credential.familyName,
    ].whereType<String>().where((part) => part.trim().isNotEmpty).toList();
    if (parts.isEmpty) return null;
    return parts.join(' ');
  }

  String _providerSubject({required User user, required String provider}) {
    final identities = user.identities ?? const [];
    for (final identity in identities) {
      if (identity.provider != provider) continue;
      final metadataSub = identity.identityData?['sub'] as String?;
      if (metadataSub != null && metadataSub.isNotEmpty) return metadataSub;
      if (identity.id.isNotEmpty) return identity.id;
    }
    return user.id;
  }
}
