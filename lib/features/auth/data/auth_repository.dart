import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto;

abstract class AuthRepository {
  bool get isLoggedIn;
  Future<void> loginWithKakaoAsync();
  Future<void> loginWithAppleAsync();
  Future<void> logoutAsync();
  Future<void> deleteAccountAsync();
  Future<ProfileDto?> fetchCurrentProfileAsync();
}
