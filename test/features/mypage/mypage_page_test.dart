import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart' show ProfileDto;
import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider, currentProfileProvider;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/provider/mypage_provider.dart'
    show myPageSummaryProvider;
import 'package:dalbit_suwon/features/mypage/ui/mypage_page.dart' show MyPagePage;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._initial, {this.deleteError});
  final bool _initial;
  final Exception? deleteError;
  bool loggedOutCalled = false;
  bool deleteAccountCalled = false;

  @override
  bool build() => _initial;

  @override
  Future<void> logoutAsync() async {
    loggedOutCalled = true;
    state = false;
  }

  @override
  Future<void> deleteAccountAsync() async {
    deleteAccountCalled = true;
    if (deleteError != null) throw deleteError!;
    state = false;
  }
}

/// 로그아웃 도중 상태 변화(state=false)가 먼저 반영되어
/// _AccountActions 위젯이 언마운트된 "이후"에 logoutAsync()가 완료되는
/// 실제 앱의 타이밍을 재현하기 위한 notifier.
class _SlowLogoutAuthNotifier extends AuthNotifier {
  final _completer = Completer<void>();

  @override
  bool build() => true;

  @override
  Future<void> logoutAsync() async {
    state = false;
    await _completer.future;
  }

  void completeLogout() => _completer.complete();
}

final _testProfile = ProfileDto(
  id: 'test-user-id',
  nickname: '수원달빛러',
  provider: 'apple',
  providerSub: 'test-sub',
  isPrivateEmail: false,
  updatedAt: DateTime(2024, 1, 1),
);

const _summary = MyPageSummary(
  favoriteSpotCount: 12,
  favoriteCourseCount: 3,
  recentCourse: CourseSummary(
    id: 'course-date-01',
    title: '화성행궁 밤길 산책',
    subtitle: '첫 방문자를 위한 야경 입문 코스',
    estimatedDurationMin: 90,
    walkingDistanceKm: 1.2,
    recommendedStartTime: '18:30',
    spotCount: 4,
    heroImageUrl: 'https://example.com/image.png',
    themeTags: ['date'],
  ),
  locationPermissionGranted: false,
  appVersion: 'v1.2.4',
);

Widget _buildApp({required bool isLoggedIn, Exception? deleteError}) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/mypage', builder: (_, _) => const MyPagePage()),
      GoRoute(path: '/login', builder: (_, _) => const Scaffold(body: Text('로그인 화면'))),
    ],
    initialLocation: '/mypage',
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(
        () => _FakeAuthNotifier(isLoggedIn, deleteError: deleteError),
      ),
      myPageSummaryProvider.overrideWith((ref) async => _summary),
      currentProfileProvider.overrideWith(
        (ref) async => isLoggedIn ? _testProfile : null,
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

Widget _buildAppWithNotifier(AuthNotifier Function() createNotifier) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/mypage', builder: (_, _) => const MyPagePage()),
      GoRoute(path: '/login', builder: (_, _) => const Scaffold(body: Text('로그인 화면'))),
    ],
    initialLocation: '/mypage',
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(createNotifier),
      myPageSummaryProvider.overrideWith((ref) async => _summary),
      currentProfileProvider.overrideWith((ref) async => _testProfile),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _pumpTall(WidgetTester tester, Widget app) async {
  await tester.binding.setSurfaceSize(const Size(400, 2200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(app);
}

void main() {
  group('MyPagePage 게스트 상태', () {
    testWidgets('로그인 유도 CTA와 최근 진행 코스, 통계를 보여준다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: false));
      await tester.pumpAndSettle();

      expect(find.text('나들이객'), findsOneWidget);
      expect(find.text('로그인 / 회원가입'), findsOneWidget);
      expect(find.text('로그인 시 기기 간 동기화'), findsOneWidget);
      expect(find.textContaining('화성행궁 밤길 산책'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('로그아웃'), findsNothing);
      expect(find.text('회원탈퇴'), findsNothing);
    });

    testWidgets('로그인 버튼을 누르면 로그인 화면으로 이동한다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: false));
      await tester.pumpAndSettle();

      await tester.tap(find.text('로그인 / 회원가입'));
      await tester.pumpAndSettle();

      expect(find.text('로그인 화면'), findsOneWidget);
    });
  });

  group('MyPagePage 로그인 상태', () {
    testWidgets('닉네임, 로그인 provider, 로그아웃/회원탈퇴 메뉴를 보여준다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: true));
      await tester.pumpAndSettle();

      expect(find.text('수원달빛러'), findsOneWidget);
      expect(find.text('Apple로 로그인함'), findsOneWidget);
      expect(find.text('로그아웃'), findsOneWidget);
      expect(find.text('회원탈퇴'), findsOneWidget);
      expect(find.text('로그인 / 회원가입'), findsNothing);
    });

    testWidgets('로그아웃 확인 시 로그인 화면으로 이동한다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: true));
      await tester.pumpAndSettle();

      await tester.tap(find.text('로그아웃'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('로그아웃').last);
      await tester.pumpAndSettle();

      expect(find.text('로그인 화면'), findsOneWidget);
    });

    testWidgets(
      '로그아웃 처리 중 상태 변화로 위젯이 먼저 언마운트되어도 로그인 화면으로 이동한다 (회귀 테스트)',
      (tester) async {
        final notifier = _SlowLogoutAuthNotifier();
        await _pumpTall(tester, _buildAppWithNotifier(() => notifier));
        await tester.pumpAndSettle();

        await tester.tap(find.text('로그아웃'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('로그아웃').last);
        // logoutAsync()가 state=false를 설정한 뒤 completer에서 대기 중인 시점까지만 진행.
        // completer가 스스로 끝나지 않으므로 pumpAndSettle은 여기서 안정된다.
        await tester.pumpAndSettle();
        // 이 시점에 isLoggedIn이 false가 되어 _AccountActions(및 그 안의
        // 로그아웃 버튼 context)가 이미 트리에서 제거되어 있어야 한다.
        expect(find.text('로그아웃'), findsNothing);

        notifier.completeLogout();
        await tester.pumpAndSettle();

        expect(find.text('로그인 화면'), findsOneWidget);
      },
    );

    testWidgets('회원탈퇴 확인 시 계정 삭제를 호출하고 로그인 화면으로 이동한다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: true));
      await tester.pumpAndSettle();

      await tester.tap(find.text('회원탈퇴'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('탈퇴'));
      await tester.pumpAndSettle();

      expect(find.text('로그인 화면'), findsOneWidget);
    });

    testWidgets('회원탈퇴 실패 시 에러 스낵바를 띄우고 로그인 상태를 유지한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(isLoggedIn: true, deleteError: Exception('네트워크 오류')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('회원탈퇴'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('탈퇴'));
      await tester.pumpAndSettle();

      expect(find.text('회원탈퇴에 실패했습니다. 잠시 후 다시 시도해 주세요.'), findsOneWidget);
      expect(find.text('수원달빛러'), findsOneWidget);
    });
  });
}
