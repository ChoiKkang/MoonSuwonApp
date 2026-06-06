import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;

class AuthRepositoryMock implements AuthRepository {
  bool _loggedIn = false;

  @override
  bool get isLoggedIn => _loggedIn;

  @override
  Future<void> loginWithKakaoAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _loggedIn = true;
  }

  @override
  Future<void> loginWithNaverAsync() async {
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
}
