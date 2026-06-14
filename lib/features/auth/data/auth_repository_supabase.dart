import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart' show ProfileDto;

class AuthRepositorySupabase implements AuthRepository {
  final _client = Supabase.instance.client;

  @override
  bool get isLoggedIn => _client.auth.currentSession != null;

  @override
  Future<void> loginWithKakaoAsync() async {
    final isInstalled = await isKakaoTalkInstalled();
    final OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final idToken = token.idToken;
    if (idToken == null) {
      throw Exception(
        'Kakao OIDC가 비활성화되어 있습니다. '
        '카카오 개발자 콘솔 → 카카오 로그인 → OpenID Connect를 활성화해주세요.',
      );
    }

    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.kakao,
      idToken: idToken,
    );

    final kakaoUser = await UserApi.instance.me();
    final kakaoEmail = kakaoUser.kakaoAccount?.email;
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
    final dto = ProfileDto(
      id: user.id,
      email: user.email ?? kakaoEmail ?? metadata['email'] as String?,
      nickname: metadata['name'] as String? ??
          metadata['full_name'] as String? ??
          metadata['user_name'] as String?,
      avatarUrl: metadata['avatar_url'] as String? ?? metadata['picture'] as String?,
      provider: provider,
      updatedAt: DateTime.now(),
    );

    await _client.from('profiles').upsert(dto.toJson());
  }
}
