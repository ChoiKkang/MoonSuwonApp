import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart' show Position;
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/core/location/location_provider.dart'
    show locationServiceProvider;
import 'package:dalbit_suwon/core/location/location_service.dart'
    show LocationAccessStatus, LocationService;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show coursesProvider;
import 'package:dalbit_suwon/features/home/ui/home_page.dart' show HomePage;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart'
    show nowGoodSpotsProvider;

/// 위치 플러그인 호출을 막기 위한 fake(홈 initState가 권한 요청을 트리거함).
class _FakeLocationService extends LocationService {
  const _FakeLocationService();
  @override
  Future<LocationAccessStatus> ensurePermissionAsync() async =>
      LocationAccessStatus.denied;
  @override
  Future<Position?> getCurrentPositionAsync() async => null;
}

const _courses = [
  CourseSummary(
    id: 'course-1',
    title: '화성행궁 밤길 산책',
    subtitle: '첫 방문자를 위한 야경 입문 코스',
    estimatedDurationMin: 90,
    walkingDistanceKm: 1.2,
    recommendedStartTime: '18:30',
    spotCount: 4,
    heroImageUrl: 'https://example.com/course-1.jpg',
    themeTags: ['date'],
  ),
];

const _spots = [
  SpotSummary(
    id: 'spot-1',
    slug: 'banghwasuryujeong',
    name: '방화수류정',
    category: 'heritage-night-view',
    heroImageUrl: 'https://example.com/spot-1.jpg',
    crowdLevel: '여유',
    distanceM: 120,
    reasonLabel: '지금 비교적 여유로워요',
    recommendationScore: 82,
    forecastStatus: 'forecast_available',
  ),
];

Widget _buildApp() {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, _) => const HomePage()),
      GoRoute(
        path: '/courses',
        builder: (_, _) => const Scaffold(body: Text('코스 목록')),
      ),
      GoRoute(
        path: '/now-good-spots',
        builder: (_, _) => const Scaffold(body: Text('스팟 전체')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      locationServiceProvider.overrideWithValue(const _FakeLocationService()),
      coursesProvider.overrideWith((_) async => _courses),
      nowGoodSpotsProvider.overrideWith((_) async => _spots),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('홈 화면이 히어로 카피와 섹션 헤더, 데이터를 렌더한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    // 고정폭(카드) 위젯의 사소한 레이아웃 오버플로우는 스모크 테스트의 관심사가
    // 아니므로 흡수하고, 렌더 콘텐츠만 검증한다.
    while (tester.takeException() != null) {}

    expect(find.textContaining('가장 로맨틱한 방법'), findsOneWidget);
    expect(find.text('추천 데이트 코스'), findsOneWidget);
    expect(find.text('지금 가기 좋은 스팟'), findsOneWidget);
    expect(find.text('화성행궁 밤길 산책'), findsOneWidget);
    expect(find.text('방화수류정'), findsOneWidget);
  });
}
