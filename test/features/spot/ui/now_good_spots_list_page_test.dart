import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart'
    show nowGoodSpotsProvider;
import 'package:dalbit_suwon/features/spot/ui/now_good_spots_list_page.dart'
    show NowGoodSpotsListPage;

const _spots = [
  SpotSummary(
    id: '00000000-0000-0000-0000-0000000000s1',
    slug: 'banghwasuryujeong',
    name: '방화수류정',
    category: 'heritage-night-view',
    heroImageUrl: 'https://example.com/spot-1.jpg',
    crowdLevel: '여유',
    distanceM: 321.4,
    reasonLabel: '지금 비교적 여유로워요',
    recommendationScore: 82.35,
    forecastStatus: 'forecast_available',
  ),
  SpotSummary(
    id: '00000000-0000-0000-0000-0000000000s2',
    slug: 'hwaseong-haenggung',
    name: '화성행궁',
    category: 'heritage-night-view',
    heroImageUrl: 'https://example.com/spot-2.jpg',
    crowdLevel: null,
    distanceM: null,
    reasonLabel: '야간 적합도 기준으로 추천해요',
    recommendationScore: 70,
    forecastStatus: 'forecast_unavailable',
  ),
];

Widget _buildApp({required AsyncValue<List<SpotSummary>> spotsState}) {
  final router = GoRouter(
    initialLocation: '/now-good-spots',
    routes: [
      GoRoute(
        path: '/now-good-spots',
        builder: (_, _) => const NowGoodSpotsListPage(),
      ),
      GoRoute(
        path: '/spot/:slug',
        builder: (_, state) =>
            Scaffold(body: Text('스팟 상세: ${state.pathParameters['slug']!}')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      nowGoodSpotsProvider.overrideWith((_) async => spotsState.value ?? []),
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
  group('NowGoodSpotsListPage', () {
    testWidgets('데이터 로드 시 스팟 카드 목록을 표시한다', (tester) async {
      await _pumpTall(tester, _buildApp(spotsState: const AsyncData(_spots)));

      expect(find.text('지금 가기 좋은 스팟'), findsOneWidget); // AppBar title
      expect(find.text('방화수류정'), findsOneWidget);
      expect(find.text('화성행궁'), findsOneWidget);
      expect(find.textContaining('지금 비교적 여유로워요'), findsOneWidget);
      expect(find.textContaining('321m'), findsOneWidget);
    });

    testWidgets('빈 목록에서는 안내 문구를 표시한다', (tester) async {
      await _pumpTall(
        tester,
        _buildApp(spotsState: const AsyncData<List<SpotSummary>>([])),
      );

      expect(find.text('지금 가기 좋은 스팟이 없어요'), findsOneWidget);
    });

    testWidgets('카드를 탭하면 /spot/:slug 로 이동한다', (tester) async {
      await _pumpTall(tester, _buildApp(spotsState: const AsyncData(_spots)));

      await tester.tap(find.text('방화수류정'));
      await tester.pumpAndSettle();

      expect(find.text('스팟 상세: banghwasuryujeong'), findsOneWidget);
    });

    testWidgets('로딩 스피너가 데이터로 전환된다 (무한 로딩 아님)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 2200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final router = GoRouter(
        initialLocation: '/now-good-spots',
        routes: [
          GoRoute(
            path: '/now-good-spots',
            builder: (_, _) => const NowGoodSpotsListPage(),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            nowGoodSpotsProvider.overrideWith((_) async {
              await Future<void>.delayed(const Duration(milliseconds: 300));
              return _spots;
            }),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      // 첫 프레임: 로딩 스피너.
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // 완료 후: 스피너 사라지고 데이터 표시.
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('방화수류정'), findsOneWidget);
    });
  });
}
