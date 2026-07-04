abstract class AuthRepository {
  bool get isLoggedIn;
  Future<void> loginWithKakaoAsync();
  Future<void> loginWithNaverAsync();
  Future<void> loginWithAppleAsync();
  Future<void> logoutAsync();
  Future<void> deleteAccountAsync();
}
