import 'dart:typed_data';

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

  /// 현재 로그인 사용자의 아바타 이미지를 Supabase Storage에 업로드하고
  /// 공개 URL을 반환한다.
  ///
  /// - [bytes]: 리사이즈/압축이 끝난 이미지 바이너리. 앱에서 이미 5MB 이하,
  ///   최대 1024x1024로 리사이즈한 뒤 전달한다.
  /// - [contentType]: `image/jpeg`, `image/png`, `image/webp` 중 하나.
  ///
  /// 반환된 URL은 `profiles.avatar_url`로 저장한다. Storage 버킷은
  /// `avatars`이며, 파일 경로는 `${userId}/avatar.<ext>` 규칙을 따른다.
  Future<String> uploadAvatarAsync({
    required Uint8List bytes,
    required String contentType,
  });
}
