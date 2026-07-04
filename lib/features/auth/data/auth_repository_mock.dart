import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart' show ProfileDto;

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
      nickname: '수원달빛러',
      provider: 'apple',
      providerSub: 'mock-sub',
      isPrivateEmail: false,
      updatedAt: DateTime.now(),
    );
  }
}
