import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show coursesProvider;
import 'package:dalbit_suwon/features/course/ui/courses_list_page.dart'
    show CoursesListPage;

const _courses = [
  CourseSummary(
    id: '00000000-0000-0000-0000-0000000000c1',
    title: '화성행궁 밤길 산책',
    subtitle: '첫 방문자를 위한 야경 입문 코스',
    estimatedDurationMin: 90,
    walkingDistanceKm: 1.2,
    recommendedStartTime: '18:30',
    spotCount: 4,
    heroImageUrl: 'https://example.com/course-1.jpg',
    themeTags: ['date'],
  ),
  CourseSummary(
    id: '00000000-0000-0000-0000-0000000000c2',
    title: '야경 사진 집중 코스',
    subtitle: '방화수류정과 용연 중심의 포토 데이트',
    estimatedDurationMin: 120,
    walkingDistanceKm: 2.8,
    recommendedStartTime: '19:00',
    spotCount: 3,
    heroImageUrl: 'https://example.com/course-2.jpg',
    themeTags: ['date', 'photo'],
  ),
];

Widget _buildApp({
  required AsyncValue<List<CourseSummary>> coursesState,
}) {
  final router = GoRouter(
    initialLocation: '/courses',
    routes: [
      GoRoute(
        path: '/courses',
        builder: (_, _) => const CoursesListPage(),
      ),
      GoRoute(
        path: '/course/:id',
        builder: (_, state) => Scaffold(
          body: Text('코스 상세: ${state.pathParameters['id']!}'),
        ),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      coursesProvider.overrideWith((_) async => coursesState.value ?? []),
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
  group('CoursesListPage', () {
    testWidgets('데이터 로드 시 코스 카드 목록을 표시한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(coursesState: const AsyncData(_courses)),
      );

      expect(find.text('추천 데이트 코스'), findsOneWidget); // AppBar title
      expect(find.text('화성행궁 밤길 산책'), findsOneWidget);
      expect(find.text('야경 사진 집중 코스'), findsOneWidget);
      expect(find.textContaining('90분'), findsOneWidget);
      expect(find.textContaining('4개 스팟'), findsOneWidget);
      expect(find.textContaining('추천 시작 18:30'), findsOneWidget);
    });

    testWidgets('빈 목록에서는 안내 문구를 표시한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(coursesState: const AsyncData<List<CourseSummary>>([])),
      );

      expect(find.text('추천 코스가 없어요'), findsOneWidget);
    });

    testWidgets('카드를 탭하면 /course/:id 로 이동한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(coursesState: const AsyncData(_courses)),
      );

      await tester.tap(find.text('화성행궁 밤길 산책'));
      await tester.pumpAndSettle();

      expect(
        find.text('코스 상세: 00000000-0000-0000-0000-0000000000c1'),
        findsOneWidget,
      );
    });
  });
}
