import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto;

abstract class AuthRepository {
  bool get isLoggedIn;
  Future<void> loginWithKakaoAsync();
  Future<void> loginWithAppleAsync();
  Future<void> logoutAsync();
  Future<void> deleteAccountAsync();
  Future<ProfileDto?> fetchCurrentProfileAsync();

  /// 현재 로그인 사용자의 프로필(닉네임/아바타 URL)을 갱신한다.
  ///
  /// 편집 가능 필드는 `nickname`과 `avatar_url` 뿐이며, 그 외 필드는
  /// 서버(auth.users, 소셜 provider)에서 관리한다.
  /// 갱신 후 반영된 최신 [ProfileDto]를 반환한다.
  Future<ProfileDto> updateProfileAsync({
    required String nickname,
    String? avatarUrl,
  });
}
