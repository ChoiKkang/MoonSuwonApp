import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/core/logger/app_logger.dart' show AppLogger;
import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart' show ProfileDto;

class AuthRepositorySupabase implements AuthRepository {
  final _client = Supabase.instance.client;

  @override
  bool get isLoggedIn => _client.auth.currentSession != null;

  @override
  Future<void> loginWithKakaoAsync() async {
    AppLogger.auth('카카오 로그인 시작');
    final isInstalled = await isKakaoTalkInstalled();
    AppLogger.auth('카카오톡 설치 여부', data: isInstalled);

    final OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

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
      var kakaoUser = await UserApi.instance.me();
      if (kakaoUser.kakaoAccount?.emailNeedsAgreement == true) {
        AppLogger.auth('이메일 추가 동의 요청');
        await UserApi.instance.loginWithNewScopes(['account_email']);
        kakaoUser = await UserApi.instance.me();
      }
      kakaoEmail = kakaoUser.kakaoAccount?.email;
      AppLogger.auth('카카오 이메일 조회', data: kakaoEmail ?? 'null');
    } catch (e, st) {
      AppLogger.error('카카오 me() 이메일 조회 실패', error: e, stackTrace: st);
    }
    await _upsertProfileAsync(provider: 'kakao', kakaoEmail: kakaoEmail);
  }

  @override
  Future<void> loginWithNaverAsync() async {
    throw UnimplementedError('네이버 로그인은 준비 중입니다.');
  }

  @override
  Future<void> loginWithAppleAsync() async {
    throw UnimplementedError('Apple 로그인은 준비 중입니다.');
  }

  @override
  Future<void> logoutAsync() async {
    try {
      await UserApi.instance.logout();
    } catch (_) {}
    await _client.auth.signOut();
  }

  Future<void> _upsertProfileAsync({
    required String provider,
    String? kakaoEmail,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final metadata = user.userMetadata ?? {};
    String? nonEmpty(String? v) => (v != null && v.isNotEmpty) ? v : null;
    final dto = ProfileDto(
      id: user.id,
      email: nonEmpty(user.email) ?? nonEmpty(kakaoEmail) ?? nonEmpty(metadata['email'] as String?),
      nickname: metadata['name'] as String? ??
          metadata['full_name'] as String? ??
          metadata['user_name'] as String?,
      avatarUrl: metadata['avatar_url'] as String? ?? metadata['picture'] as String?,
      provider: provider,
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
}
