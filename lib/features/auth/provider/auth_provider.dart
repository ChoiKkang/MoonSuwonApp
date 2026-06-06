import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/auth_repository_mock.dart' show AuthRepositoryMock;

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryMock();

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() => ref.read(authRepositoryProvider).isLoggedIn;

  Future<void> loginWithKakaoAsync() async {
    await ref.read(authRepositoryProvider).loginWithKakaoAsync();
    state = true;
  }

  Future<void> loginWithNaverAsync() async {
    await ref.read(authRepositoryProvider).loginWithNaverAsync();
    state = true;
  }

  Future<void> loginWithAppleAsync() async {
    await ref.read(authRepositoryProvider).loginWithAppleAsync();
    state = true;
  }

  Future<void> logoutAsync() async {
    await ref.read(authRepositoryProvider).logoutAsync();
    state = false;
  }
}
