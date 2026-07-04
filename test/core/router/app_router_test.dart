import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/core/router/app_router.dart'
    show appRouterProvider;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this.loggedIn);
  final bool loggedIn;

  @override
  bool build() => loggedIn;
}

void main() {
  testWidgets('비회원 사용자는 앱 실행 시 홈으로 진입한다', (tester) async {
    late final ProviderContainer container;
    addTearDown(() => container.dispose());

    container = ProviderContainer(
      overrides: [
        authNotifierProvider.overrideWith(() => _FakeAuthNotifier(false)),
      ],
    );
    final router = container.read(appRouterProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/');
    expect(find.text('추천 데이트 코스'), findsOneWidget);
  });

  testWidgets('로그인 사용자가 로그인 화면에 접근하면 홈으로 보낸다', (tester) async {
    late final ProviderContainer container;
    addTearDown(() => container.dispose());

    container = ProviderContainer(
      overrides: [
        authNotifierProvider.overrideWith(() => _FakeAuthNotifier(true)),
      ],
    );
    final router = container.read(appRouterProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    router.go('/login');
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/');
  });
}
