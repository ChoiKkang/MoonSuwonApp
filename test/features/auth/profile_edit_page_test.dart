import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show currentProfileProvider;
import 'package:dalbit_suwon/features/auth/ui/profile_edit_page.dart'
    show ProfileEditPage;

final _profile = ProfileDto(
  id: 'test-user-id',
  nickname: '수원달빛러',
  provider: 'apple',
  providerSub: 'test-sub',
  isPrivateEmail: false,
  updatedAt: DateTime(2026, 1, 1),
);

Widget _buildApp(AsyncValue<ProfileDto?> profileState) {
  final router = GoRouter(
    initialLocation: '/profile/edit',
    routes: [
      GoRoute(
        path: '/profile/edit',
        builder: (_, _) => const ProfileEditPage(),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      currentProfileProvider.overrideWith((_) async => profileState.value),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('프로필이 있으면 편집 폼과 닉네임을 렌더한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp(AsyncData(_profile)));
    await tester.pumpAndSettle();

    expect(find.text('프로필 편집'), findsOneWidget);
    expect(find.text('수원달빛러'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('프로필이 없으면 로그인 필요 안내를 렌더한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp(const AsyncData<ProfileDto?>(null)));
    await tester.pumpAndSettle();

    expect(find.text('로그인이 필요합니다.'), findsOneWidget);
  });
}
