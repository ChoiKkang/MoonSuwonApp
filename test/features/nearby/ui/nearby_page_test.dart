import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_search_origin.dart'
    show NearbySearchOrigin;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show
        nearbyFiltersControllerProvider,
        nearbyPlacesProvider,
        nearbySearchOriginProvider;
import 'package:dalbit_suwon/features/nearby/ui/nearby_page.dart'
    show NearbyPage;
import 'package:dalbit_suwon/features/nearby/ui/widgets/nearby_place_card.dart'
    show NearbyPlaceCard;

const _banghwa = NearbyPlace(
  id: 'place-1',
  slug: 'banghwasuryujeong',
  officialName: '방화수류정',
  displayName: '방화수류정(동북각루)',
  lat: 37.2870,
  lng: 127.0175,
  distanceM: 128.4,
  category: 'heritage-night-view',
  nightHighlight: '수면 반사와 정자 조명이 함께 보이는 구간',
  crowdLevel: '여유',
  recommendationScore: 92,
  nightSuitabilityScore: 95,
  forecastStatus: 'forecast_available',
);
const _yongyeon = NearbyPlace(
  id: 'place-2',
  slug: 'yongyeon',
  officialName: '용연',
  displayName: '용연',
  lat: 37.2885,
  lng: 127.0168,
  distanceM: 320.9,
  category: 'heritage-night-view',
  nightHighlight: '달빛 반영 연못',
  forecastStatus: 'forecast_unavailable',
);

Widget _buildApp({
  required NearbySearchOrigin origin,
  required List<NearbyPlace> places,
  List<String>? navigationLog,
}) {
  final router = GoRouter(
    initialLocation: '/nearby',
    routes: [
      GoRoute(path: '/nearby', builder: (_, _) => const NearbyPage()),
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('홈 화면')),
      ),
      GoRoute(
        path: '/mypage',
        builder: (_, _) => const Scaffold(body: Text('마이 화면')),
      ),
      GoRoute(
        path: '/bookmarks',
        builder: (_, _) => const Scaffold(body: Text('찜 화면')),
      ),
      GoRoute(
        path: '/spot/:slug',
        builder: (context, state) {
          navigationLog?.add(state.pathParameters['slug']!);
          return Scaffold(
            body: Text('스팟 상세 ${state.pathParameters['slug']}'),
          );
        },
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      nearbySearchOriginProvider.overrideWith((ref) async => origin),
      nearbyPlacesProvider.overrideWith((ref) async => places),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _pumpTall(WidgetTester tester, Widget app) async {
  await tester.binding.setSurfaceSize(const Size(400, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(app);
}

Future<void> _settleMap(WidgetTester tester, {int steps = 10}) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  testWidgets('로드 완료 후 인근 스팟 이름·거리 뱃지·혼잡도 뱃지·기본 헤더가 보인다', (
    tester,
  ) async {
    await _pumpTall(
      tester,
      _buildApp(
        origin: const NearbySearchOrigin(
          lat: 37.28617,
          lng: 127.01203,
          isFallback: false,
        ),
        places: const [_banghwa, _yongyeon],
      ),
    );
    await _settleMap(tester);

    expect(find.widgetWithText(AppBar, '내 주변'), findsOneWidget);
    expect(find.text('가까운 순 · 2곳'), findsOneWidget);
    expect(find.text('방화수류정(동북각루)'), findsOneWidget);
    expect(find.text('용연'), findsOneWidget);
    expect(find.text('128m'), findsOneWidget);
    expect(find.text('321m'), findsOneWidget);
    // 방화수류정은 forecast_available이라 여유 뱃지가 뜬다.
    expect(
      find.descendant(
        of: find.widgetWithText(NearbyPlaceCard, '방화수류정(동북각루)'),
        matching: find.text('여유'),
      ),
      findsOneWidget,
    );
    // 용연은 forecast_unavailable이라 crowd 뱃지가 없다.
    expect(
      find.descendant(
        of: find.widgetWithText(NearbyPlaceCard, '용연'),
        matching: find.text('여유'),
      ),
      findsNothing,
    );
  });

  testWidgets('fallback 좌표일 때 안내 배너를 노출한다', (tester) async {
    await _pumpTall(
      tester,
      _buildApp(origin: NearbySearchOrigin.fallback, places: const [_banghwa]),
    );
    await _settleMap(tester);

    expect(find.textContaining('수원화성 기준'), findsOneWidget);
  });

  testWidgets('스팟이 없으면 빈 상태 문구가 보인다', (tester) async {
    await _pumpTall(
      tester,
      _buildApp(
        origin: const NearbySearchOrigin(
          lat: 37.28617,
          lng: 127.01203,
          isFallback: false,
        ),
        places: const [],
      ),
    );
    await _settleMap(tester);

    expect(find.text('가까운 순 · 0곳'), findsOneWidget);
    expect(find.text('주변에 아직 등록된 스팟이 없어요'), findsOneWidget);
  });

  testWidgets('카드를 한 번 탭하면 선택 상태만 바뀌고, 다시 탭하면 스팟 상세로 이동한다', (
    tester,
  ) async {
    final navigationLog = <String>[];
    await _pumpTall(
      tester,
      _buildApp(
        origin: const NearbySearchOrigin(
          lat: 37.28617,
          lng: 127.01203,
          isFallback: false,
        ),
        places: const [_banghwa, _yongyeon],
        navigationLog: navigationLog,
      ),
    );
    await _settleMap(tester);

    final banghwaCard = find.widgetWithText(
      NearbyPlaceCard,
      '방화수류정(동북각루)',
    );
    expect(banghwaCard, findsOneWidget);

    await tester.tap(banghwaCard);
    await _settleMap(tester, steps: 6);
    expect(navigationLog, isEmpty);

    await tester.tap(banghwaCard);
    await _settleMap(tester, steps: 6);
    expect(navigationLog, ['banghwasuryujeong']);
  });

  testWidgets('AppBar의 내 위치 버튼을 누르면 fallback 상태에서는 안내 스낵바가 뜬다', (
    tester,
  ) async {
    await _pumpTall(
      tester,
      _buildApp(origin: NearbySearchOrigin.fallback, places: const [_banghwa]),
    );
    await _settleMap(tester);

    final recenterButton = find.byTooltip('내 위치로 이동');
    expect(recenterButton, findsOneWidget);

    await tester.tap(recenterButton);
    await _settleMap(tester);

    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('위치 권한이 없어 수원화성 기준으로 보여드려요.'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('필터 아이콘 탭 → 시트 열림, 정렬 변경 시 헤더 라벨이 갱신된다', (tester) async {
    late ProviderContainer container;
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      initialLocation: '/nearby',
      routes: [
        GoRoute(path: '/nearby', builder: (_, _) => const NearbyPage()),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          nearbySearchOriginProvider.overrideWith(
            (ref) async => const NearbySearchOrigin(
              lat: 37.28617,
              lng: 127.01203,
              isFallback: false,
            ),
          ),
          nearbyPlacesProvider.overrideWith((ref) async => const [_banghwa]),
        ],
        child: Builder(
          builder: (context) {
            container = ProviderScope.containerOf(context);
            return MaterialApp.router(routerConfig: router);
          },
        ),
      ),
    );
    await _settleMap(tester);

    // 처음엔 "가까운 순 · 1곳"
    expect(find.text('가까운 순 · 1곳'), findsOneWidget);

    // 필터 아이콘 탭 → 시트 열림.
    await tester.tap(find.text('필터'));
    await _settleMap(tester);
    expect(find.text('반경'), findsOneWidget);
    expect(find.text('정렬'), findsOneWidget);
    expect(find.text('혼잡도'), findsOneWidget);

    // 시트 안에서 '추천 순' 선택.
    await tester.tap(find.text('추천 순'));
    await _settleMap(tester);

    // 상태 반영 확인.
    final filters = container.read(nearbyFiltersControllerProvider);
    expect(filters.sortBy, NearbySortBy.recommendation);

    // 시트를 닫는다.
    await tester.tap(find.text('적용'));
    await _settleMap(tester);

    // 헤더 라벨이 바뀌었다.
    expect(find.text('추천 순 · 1곳'), findsOneWidget);
  });

  testWidgets('활성 필터가 있으면 chip과 초기화 버튼이 리스트 상단에 표시된다', (tester) async {
    late ProviderContainer container;
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      initialLocation: '/nearby',
      routes: [
        GoRoute(path: '/nearby', builder: (_, _) => const NearbyPage()),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          nearbySearchOriginProvider.overrideWith(
            (ref) async => const NearbySearchOrigin(
              lat: 37.28617,
              lng: 127.01203,
              isFallback: false,
            ),
          ),
          nearbyPlacesProvider.overrideWith((ref) async => const [_banghwa]),
        ],
        child: Builder(
          builder: (context) {
            container = ProviderScope.containerOf(context);
            return MaterialApp.router(routerConfig: router);
          },
        ),
      ),
    );
    await _settleMap(tester);

    // 처음엔 chip 없음.
    expect(find.text('500m 이내'), findsNothing);
    expect(find.text('여유'), findsOneWidget); // 카드 뱃지의 여유 (한 개)

    // 프로바이더로 필터 직접 설정.
    container.read(nearbyFiltersControllerProvider.notifier).setRadius(500);
    container
        .read(nearbyFiltersControllerProvider.notifier)
        .toggleCrowdLevel('여유');
    await _settleMap(tester);

    // chip 노출 (카드 뱃지의 여유 1개 + 필터 chip의 여유 1개 = 2개)
    expect(find.text('500m 이내'), findsOneWidget);
    expect(find.text('여유'), findsNWidgets(2));
    // 초기화 텍스트 버튼 (활성 필터 row).
    expect(find.text('초기화'), findsOneWidget);

    // 초기화 탭.
    await tester.tap(find.text('초기화'));
    await _settleMap(tester);

    expect(find.text('500m 이내'), findsNothing);
    expect(find.text('여유'), findsOneWidget); // 카드 뱃지만 남는다.
    expect(
      container.read(nearbyFiltersControllerProvider).isDefault,
      isTrue,
    );
  });
}
