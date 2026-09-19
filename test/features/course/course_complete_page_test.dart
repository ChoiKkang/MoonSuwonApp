import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseDetailProvider;
import 'package:dalbit_suwon/features/course/ui/course_complete_page.dart'
    show CourseCompletePage;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._initial);
  final bool _initial;
  @override
  bool build() => _initial;
}

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
  ],
);

Widget _buildApp() {
  final router = GoRouter(
    initialLocation: '/course/course-1/complete',
    routes: [
      GoRoute(
        path: '/course/:id/complete',
        builder: (_, _) => const CourseCompletePage(courseId: 'course-1'),
      ),
      GoRoute(path: '/', builder: (_, _) => const Scaffold(body: Text('홈'))),
      GoRoute(
        path: '/mypage',
        builder: (_, _) => const Scaffold(body: Text('마이페이지')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier(false)),
      courseDetailProvider('course-1').overrideWith((_) async => _detail),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('코스 완료 화면이 축하 메시지·코스명·공유 CTA를 렌더한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('코스 완주를\n축하합니다!'), findsOneWidget);
    expect(find.text('야경 사진 집중 코스'), findsOneWidget);
    expect(find.text('이미지로 저장 및 공유하기'), findsOneWidget);
    expect(find.text('홈으로 돌아가기'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
