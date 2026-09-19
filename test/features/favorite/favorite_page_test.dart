import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;
import 'package:dalbit_suwon/features/favorite/provider/favorite_provider.dart'
    show favoriteRepositoryProvider;
import 'package:dalbit_suwon/features/favorite/ui/favorite_page.dart'
    show FavoritePage;

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._initial);
  final bool _initial;
  @override
  bool build() => _initial;
}

class _FakeFavoriteRepository implements FavoriteRepository {
  @override
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync() async => [
    const FavoriteSpotSummary(
      placeId: 'spot-1',
      slug: 'banghwasuryujeong',
      name: '방화수류정',
      category: 'heritage-night-view',
      heroImageUrl: 'https://example.com/spot-1.jpg',
    ),
  ];

  @override
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync() async => [
    const FavoriteCourseSummary(
      courseId: 'course-1',
      slug: 'course-1',
      title: '화성행궁 밤길 산책',
      estimatedDurationMin: 90,
      spotCount: 4,
      heroImageUrl: 'https://example.com/course-1.jpg',
      themeTags: ['date'],
    ),
  ];

  @override
  Future<void> addSpotAsync(FavoriteSpotSummary spot) async {}
  @override
  Future<void> addCourseAsync(FavoriteCourseSummary course) async {}
  @override
  Future<void> removeAsync(FavoriteTarget target) async {}
}

Widget _buildApp({required bool isLoggedIn}) {
  final router = GoRouter(
    initialLocation: '/bookmarks',
    routes: [
      GoRoute(path: '/', builder: (_, _) => const Scaffold(body: Text('홈'))),
      GoRoute(path: '/bookmarks', builder: (_, _) => const FavoritePage()),
      GoRoute(
        path: '/course/:id',
        builder: (_, _) => const Scaffold(body: Text('코스 상세')),
      ),
      GoRoute(
        path: '/spot/:id',
        builder: (_, _) => const Scaffold(body: Text('스팟 상세')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      authNotifierProvider.overrideWith(() => _FakeAuthNotifier(isLoggedIn)),
      favoriteRepositoryProvider.overrideWithValue(_FakeFavoriteRepository()),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('게스트는 로그인 동기화 배너와 찜 목록을 본다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp(isLoggedIn: false));
    await tester.pumpAndSettle();

    expect(find.text('찜'), findsWidgets); // 앱바 제목 + 하단 탭 라벨
    expect(find.text('코스'), findsOneWidget);
    expect(find.text('스팟'), findsOneWidget);
    expect(find.text('로그인하고 기기 간에도 찜을 동기화하세요'), findsOneWidget);
    // 기본 탭(코스)에 찜한 코스가 보인다.
    expect(find.text('화성행궁 밤길 산책'), findsOneWidget);
  });

  testWidgets('로그인 상태에서는 동기화 배너를 숨긴다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp(isLoggedIn: true));
    await tester.pumpAndSettle();

    expect(find.text('로그인하고 기기 간에도 찜을 동기화하세요'), findsNothing);
    expect(find.text('화성행궁 밤길 산책'), findsOneWidget);
  });
}
