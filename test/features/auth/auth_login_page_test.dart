import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/data/auth_exceptions.dart' show EmailAlreadyInUseException;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart' show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/auth/ui/auth_login_page.dart' show AuthLoginPage;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier({Exception? error}) : _error = error;
  final Exception? _error;

  @override
  bool build() => false;

  @override
  Future<void> loginWithKakaoAsync() async {
    if (_error != null) throw _error!;
  }
}

Widget _buildApp({Exception? loginError}) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const Scaffold(body: Text('홈'))),
      GoRoute(path: '/login', builder: (_, __) => const AuthLoginPage()),
    ],
    initialLocation: '/login',
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier(error: loginError)),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('AuthLoginPage 카카오 로그인', () {
    testWidgets('이미 가입된 이메일이면 스낵바를 띄우고 로그인 페이지를 유지한다', (tester) async {
      await tester.pumpWidget(
        _buildApp(loginError: const EmailAlreadyInUseException()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('카카오로 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('이미 가입된 계정입니다.'), findsOneWidget);
      expect(find.text('카카오로 시작하기'), findsOneWidget);
    });

    testWidgets('로그인 오류 발생 시 에러 스낵바를 띄우고 로그인 페이지를 유지한다', (tester) async {
      await tester.pumpWidget(
        _buildApp(loginError: Exception('네트워크 오류')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('카카오로 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('카카오 로그인에 실패했습니다. 다시 시도해 주세요.'), findsOneWidget);
      expect(find.text('카카오로 시작하기'), findsOneWidget);
    });

    testWidgets('로그인 성공 시 홈으로 이동한다', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('카카오로 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('홈'), findsOneWidget);
      expect(find.text('카카오로 시작하기'), findsNothing);
    });
  });
}
