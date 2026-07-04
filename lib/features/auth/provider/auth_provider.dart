import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/auth/data/auth_repository.dart' show AuthRepository;
import 'package:dalbit_suwon/features/auth/data/auth_repository_supabase.dart' show AuthRepositorySupabase;

part 'auth_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositorySupabase();

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  bool build() {
    ref.onDispose(
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
        state = data.session != null;
      }).cancel,
    );
    return Supabase.instance.client.auth.currentSession != null;
  }

  Future<void> loginWithKakaoAsync() async {
    await ref.read(authRepositoryProvider).loginWithKakaoAsync();
  }

  Future<void> loginWithNaverAsync() async {
    await ref.read(authRepositoryProvider).loginWithNaverAsync();
  }

  Future<void> loginWithAppleAsync() async {
    await ref.read(authRepositoryProvider).loginWithAppleAsync();
  }

  Future<void> logoutAsync() async {
    await ref.read(authRepositoryProvider).logoutAsync();
  }

  Future<void> deleteAccountAsync() async {
    await ref.read(authRepositoryProvider).deleteAccountAsync();
  }
}
