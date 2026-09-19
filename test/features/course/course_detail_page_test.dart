import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseDetailProvider;
import 'package:dalbit_suwon/features/course/ui/course_detail_page.dart'
    show CourseDetailPage;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;
import 'package:dalbit_suwon/features/favorite/provider/favorite_provider.dart'
    show favoriteRepositoryProvider;

class _FakeFavoriteRepository implements FavoriteRepository {
  @override
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync() async => const [];

  @override
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync() async =>
      const [];

  @override
  Future<void> addSpotAsync(FavoriteSpotSummary spot) async {}

  @override
  Future<void> addCourseAsync(FavoriteCourseSummary course) async {}

  @override
  Future<void> removeAsync(FavoriteTarget target) async {}
}

const _detail = CourseDetail(
  id: 'course-walk-01',
  title: '산책 후 행리단길 마무리 코스',
  subtitle: '성곽 산책부터 카페까지',
  description: '성곽을 따라 걸으며 야경을 감상하는 코스입니다.',
  estimatedDurationMin: 150,
  walkingDistanceKm: 3.5,
  recommendedStartTime: '17:30',
  heroImageUrl: 'https://example.com/course-hero.jpg',
  themeTags: ['date', 'walk'],
  spots: [
    Spot(
      id: 'spot-banghwasuryujeong',
      name: '방화수류정',
      summary: '수원화성 야경의 꽃',
      imageUrl: 'https://example.com/spot.jpg',
      lat: 37.2872,
      lng: 127.0176,
      missionRadiusM: 80,
      missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
      petPolicy: 'allowed',
      petNote: '리드줄 착용 시 동반 가능',
    ),
    Spot(
      id: 'spot-yongyeon',
      name: '용연',
      summary: '수면에 비친 달빛',
      imageUrl: 'https://example.com/spot2.jpg',
      lat: 37.2879,
      lng: 127.0180,
      missionRadiusM: 80,
      missionPrompt: '수면에 비친 반영을 담아보세요.',
    ),
  ],
);

Widget _buildApp() {
  final router = GoRouter(
    initialLocation: '/course/course-walk-01',
    routes: [
      GoRoute(
        path: '/course/:id',
        builder: (_, _) => const CourseDetailPage(courseId: 'course-walk-01'),
      ),
      GoRoute(
        path: '/spot/:id',
        builder: (_, state) =>
            Scaffold(body: Text('스팟 상세: ${state.pathParameters['id']!}')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      courseDetailProvider(
        'course-walk-01',
      ).overrideWith((_) async => _detail),
      favoriteRepositoryProvider.overrideWithValue(_FakeFavoriteRepository()),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('반려동물 정책이 있는 스팟에만 칩을 표시한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    // 방화수류정(allowed)에는 칩이 뜨고, 용연(unknown)에는 없다.
    expect(find.text('반려동물 동반 가능'), findsOneWidget);
  });

  testWidgets('타임라인 스팟을 탭하면 스팟 상세로 이동한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('방화수류정'));
    await tester.pumpAndSettle();

    expect(find.text('스팟 상세: spot-banghwasuryujeong'), findsOneWidget);
  });
}
