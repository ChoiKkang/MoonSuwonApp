import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseDetailProvider;
import 'package:dalbit_suwon/features/course/ui/course_progress_page.dart'
    show CourseProgressPage;

const _detail = CourseDetail(
  id: 'course-1',
  title: '야경 사진 집중 코스',
  subtitle: '방화수류정과 용연 중심',
  description: '성곽을 따라 야경을 담는 코스입니다.',
  estimatedDurationMin: 120,
  walkingDistanceKm: 2.8,
  recommendedStartTime: '19:00',
  heroImageUrl: 'https://example.com/hero.jpg',
  themeTags: ['photo'],
  spots: [
    Spot(
      id: 'spot-banghwasuryujeong',
      name: '방화수류정',
      summary: '수원화성 야경의 꽃',
      imageUrl: 'https://example.com/s1.jpg',
      lat: 37.2872,
      lng: 127.0176,
      missionRadiusM: 80,
      missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
    ),
    Spot(
      id: 'spot-yongyeon',
      name: '용연',
      summary: '수면에 비친 달빛',
      imageUrl: 'https://example.com/s2.jpg',
      lat: 37.2879,
      lng: 127.0180,
      missionRadiusM: 80,
      missionPrompt: '수면에 비친 반영을 담아보세요.',
    ),
  ],
);

Widget _buildApp() {
  final router = GoRouter(
    initialLocation: '/course/course-1/progress',
    routes: [
      GoRoute(
        path: '/course/:id/progress',
        builder: (_, _) => const CourseProgressPage(courseId: 'course-1'),
      ),
      GoRoute(
        path: '/course/:id/complete',
        builder: (_, _) => const Scaffold(body: Text('완료 화면')),
      ),
      GoRoute(
        path: '/spot/:id',
        builder: (_, _) => const Scaffold(body: Text('스팟 상세')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      courseDetailProvider('course-1').overrideWith((_) async => _detail),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('코스 진행 화면이 타임라인과 현재 스팟, CTA를 렌더한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('코스 진행 현황'), findsOneWidget);
    expect(find.text('야경 사진 집중 코스'), findsOneWidget);
    expect(find.text('PHOTO FOCUS COURSE'), findsOneWidget);
    expect(find.text('방화수류정'), findsOneWidget);
    expect(find.text('용연'), findsOneWidget);
    // 진행 시작(currentIndex 0) 상태의 CTA.
    expect(find.text('미션으로 돌아가기'), findsOneWidget);
    expect(find.text('현재 장소'), findsOneWidget);
  });
}
