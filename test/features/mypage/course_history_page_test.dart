import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CourseHistoryEntryDto;
import 'package:dalbit_suwon/features/mypage/ui/course_history_page.dart'
    show CourseHistoryPage, userCourseHistoryProvider;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._initial);
  final bool _initial;

  @override
  bool build() => _initial;

  @override
  Future<void> logoutAsync() async {
    state = false;
  }

  @override
  Future<void> deleteAccountAsync() async {
    state = false;
  }
}

final _entries = <CourseHistoryEntryDto>[
  CourseHistoryEntryDto(
    progressId: '00000000-0000-0000-0000-000000000001',
    courseId: '00000000-0000-0000-0000-0000000000c1',
    courseSlug: 'night-photo-01',
    heroTitle: '야경 사진 집중 코스',
    subtitle: '방화수류정 포토 데이트',
    heroImageUrl: 'https://example.com/course-1.jpg',
    status: 'completed',
    startedAt: DateTime(2026, 7, 20, 19),
    completedAt: DateTime(2026, 7, 20, 21),
    checkinCount: 4,
    spotCount: 4,
    walkingDistanceKm: 2.8,
    estimatedDurationMin: 120,
  ),
  CourseHistoryEntryDto(
    progressId: '00000000-0000-0000-0000-000000000002',
    courseId: '00000000-0000-0000-0000-0000000000c2',
    courseSlug: 'first-visit-01',
    heroTitle: '화성행궁 밤길 산책',
    subtitle: '입문 코스',
    heroImageUrl: null,
    status: 'in_progress',
    startedAt: DateTime(2026, 8, 30, 18),
    completedAt: null,
    checkinCount: 2,
    spotCount: 4,
    walkingDistanceKm: 1.2,
    estimatedDurationMin: 90,
  ),
];

Widget _buildApp({
  required bool isLoggedIn,
  required AsyncValue<List<CourseHistoryEntryDto>> historyState,
}) {
  final router = GoRouter(
    initialLocation: '/mypage/history',
    routes: [
      GoRoute(
        path: '/mypage/history',
        builder: (_, _) => const CourseHistoryPage(),
      ),
      GoRoute(
        path: '/course/:id',
        builder: (_, state) => Scaffold(
          body: Text('코스 상세: ${state.pathParameters['id']!}'),
        ),
      ),
      GoRoute(
        path: '/course/:id/complete',
        builder: (_, state) => Scaffold(
          body: Text('완료 화면: ${state.pathParameters['id']!}'),
        ),
      ),
      GoRoute(
        path: '/course/:id/progress',
        builder: (_, state) => Scaffold(
          body: Text('진행 화면: ${state.pathParameters['id']!}'),
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) => const Scaffold(body: Text('로그인 화면')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier(isLoggedIn)),
      userCourseHistoryProvider.overrideWith(
        (_) async => historyState.value ?? const [],
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _pumpTall(WidgetTester tester, Widget app) async {
  await tester.binding.setSurfaceSize(const Size(400, 2200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  group('CourseHistoryPage', () {
    testWidgets('비로그인 상태에서는 로그인 유도 CTA를 보여준다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(
          isLoggedIn: false,
          historyState: const AsyncData<List<CourseHistoryEntryDto>>([]),
        ),
      );

      expect(find.text('로그인이 필요합니다'), findsOneWidget);
      expect(find.text('로그인 / 회원가입'), findsOneWidget);
    });

    testWidgets('로그인·이력 없음이면 빈 상태 안내를 보여준다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(
          isLoggedIn: true,
          historyState: const AsyncData<List<CourseHistoryEntryDto>>([]),
        ),
      );

      expect(find.text('아직 진행한 코스가 없어요'), findsOneWidget);
    });

    testWidgets('이력이 있으면 상태 라벨과 날짜, 진행률을 표시한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(
          isLoggedIn: true,
          historyState: AsyncData(_entries),
        ),
      );

      expect(find.text('야경 사진 집중 코스'), findsOneWidget);
      expect(find.text('완주'), findsOneWidget);
      expect(find.text('2026.07.20'), findsOneWidget);
      expect(find.text('4/4 스팟'), findsOneWidget);

      expect(find.text('화성행궁 밤길 산책'), findsOneWidget);
      expect(find.text('진행 중'), findsOneWidget);
      expect(find.text('2/4 스팟'), findsOneWidget);
    });

    testWidgets('완료된 이력을 탭하면 /course/:id/complete 로 이동', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(
          isLoggedIn: true,
          historyState: AsyncData(_entries),
        ),
      );

      await tester.tap(find.text('야경 사진 집중 코스'));
      await tester.pumpAndSettle();

      expect(
        find.text('완료 화면: 00000000-0000-0000-0000-0000000000c1'),
        findsOneWidget,
      );
    });

    testWidgets('진행 중 이력을 탭하면 /course/:id/progress 로 이동', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(
          isLoggedIn: true,
          historyState: AsyncData(_entries),
        ),
      );

      await tester.tap(find.text('화성행궁 밤길 산책'));
      await tester.pumpAndSettle();

      expect(
        find.text('진행 화면: 00000000-0000-0000-0000-0000000000c2'),
        findsOneWidget,
      );
    });
  });
}
