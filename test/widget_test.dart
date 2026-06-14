import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/router/app_router.dart'
    show appRouterProvider;
import 'package:dalbit_suwon/main.dart' show DalbitSuwonApp;

void main() {
  testWidgets('DalbitSuwonApp renders with injected router', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('달빛수원')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appRouterProvider.overrideWithValue(router)],
        child: const DalbitSuwonApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('달빛수원'), findsOneWidget);
  });
}
