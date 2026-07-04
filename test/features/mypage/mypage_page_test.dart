import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/provider/mypage_provider.dart'
    show myPageSummaryProvider;
import 'package:dalbit_suwon/features/mypage/ui/mypage_page.dart' show MyPagePage;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._initial);
  final bool _initial;
  bool loggedOutCalled = false;

  @override
  bool build() => _initial;

  @override
  Future<void> logoutAsync() async {
    loggedOutCalled = true;
    state = false;
  }
}

const _summary = MyPageSummary(
  nickname: '수원달빛러',
  avatarUrl: null,
  loginProviderLabel: 'Apple로 로그인함',
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

Widget _buildApp({required bool isLoggedIn}) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/mypage', builder: (_, _) => const MyPagePage()),
      GoRoute(path: '/login', builder: (_, _) => const Scaffold(body: Text('로그인 화면'))),
    ],
    initialLocation: '/mypage',
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier(isLoggedIn)),
      myPageSummaryProvider.overrideWith((ref) async => _summary),
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

    testWidgets('로그아웃 확인 시 게스트 화면으로 전환된다', (tester) async {
      await _pumpTall(tester, _buildApp(isLoggedIn: true));
      await tester.pumpAndSettle();

      await tester.tap(find.text('로그아웃'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('로그아웃').last);
      await tester.pumpAndSettle();

      expect(find.text('나들이객'), findsOneWidget);
    });
  });
}
