import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/data/auth_exceptions.dart'
    show EmailAlreadyInUseException;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/auth/ui/auth_login_page.dart'
    show AuthLoginPage;
import 'package:dalbit_suwon/shared/widgets/kakao_login_button.dart'
    show KakaoLoginButton;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier({this.kakaoError, this.appleError});
  final Exception? kakaoError;
  final Exception? appleError;

  @override
  bool build() => false;

  @override
  Future<void> loginWithKakaoAsync() async {
    if (kakaoError != null) throw kakaoError!;
  }

  @override
  Future<void> loginWithAppleAsync() async {
    if (appleError != null) throw appleError!;
  }
}

Widget _buildApp({Exception? kakaoError, Exception? appleError}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('홈')),
      ),
      GoRoute(path: '/login', builder: (_, _) => const AuthLoginPage()),
    ],
    initialLocation: '/login',
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(
        () => _FakeAuthNotifier(kakaoError: kakaoError, appleError: appleError),
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('AuthLoginPage 카카오 로그인', () {
    testWidgets('공식 카카오 로그인 버튼이 노출된다', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      expect(find.byType(KakaoLoginButton), findsOneWidget);
      expect(
        find.bySemanticsLabel('카카오 로그인'),
        findsWidgets,
        reason: '카카오 로그인 버튼은 접근성 레이블을 노출해야 한다.',
      );
    });

    testWidgets('이미 가입된 이메일이면 스낵바를 띄우고 로그인 페이지를 유지한다', (tester) async {
      await tester.pumpWidget(
        _buildApp(kakaoError: const EmailAlreadyInUseException()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(KakaoLoginButton));
      await tester.pumpAndSettle();

      expect(find.text('이미 가입된 계정입니다.'), findsOneWidget);
      expect(find.byType(KakaoLoginButton), findsOneWidget);
    });

    testWidgets('로그인 오류 발생 시 에러 스낵바를 띄우고 로그인 페이지를 유지한다', (tester) async {
      await tester.pumpWidget(_buildApp(kakaoError: Exception('네트워크 오류')));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(KakaoLoginButton));
      await tester.pumpAndSettle();

      expect(find.text('카카오 로그인에 실패했습니다. 다시 시도해 주세요.'), findsOneWidget);
      expect(find.byType(KakaoLoginButton), findsOneWidget);
    });

    testWidgets('로그인 성공 시 홈으로 이동한다', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(KakaoLoginButton));
      await tester.pumpAndSettle();

      expect(find.text('홈'), findsOneWidget);
      expect(find.byType(KakaoLoginButton), findsNothing);
    });

    testWidgets('네이버 로그인 버튼은 노출되지 않는다', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('네이버'), findsNothing);
    });
  });

  group('AuthLoginPage Apple 로그인', () {
    testWidgets('로그인 오류 발생 시 에러 스낵바를 띄우고 로그인 페이지를 유지한다', (tester) async {
      await tester.pumpWidget(_buildApp(appleError: Exception('취소')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple로 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('Apple 로그인에 실패했습니다. 다시 시도해 주세요.'), findsOneWidget);
      expect(find.text('Apple로 시작하기'), findsOneWidget);
    });

    testWidgets('로그인 성공 시 홈으로 이동한다', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple로 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('홈'), findsOneWidget);
      expect(find.text('Apple로 시작하기'), findsNothing);
    });
  });
}
