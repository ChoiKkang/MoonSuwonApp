import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/crowd_repository.dart'
    show CrowdForecastRepository;
import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast, DailyCrowd;
import 'package:dalbit_suwon/features/spot/provider/crowd_provider.dart'
    show crowdForecastRepositoryMockProvider;
import 'package:dalbit_suwon/features/spot/ui/widgets/crowd_forecast_section.dart'
    show CrowdForecastSection;

class _FakeCrowdRepo implements CrowdForecastRepository {
  const _FakeCrowdRepo(this._forecast);
  final CrowdForecast _forecast;

  @override
  Future<CrowdForecast> fetchCrowdForecastAsync(String placeId) async =>
      _forecast;
}

CrowdForecast _seriesFromToday() {
  final now = DateTime.now();
  String fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
  final base = DateTime(now.year, now.month, now.day);
  return CrowdForecast(
    days: [
      DailyCrowd(date: fmt(base), level: '혼잡', score: 82, dataStatus: 'fresh'),
      DailyCrowd(
        date: fmt(base.add(const Duration(days: 1))),
        level: '보통',
        score: 55,
        dataStatus: 'fresh',
      ),
    ],
  );
}

Widget _host(CrowdForecast forecast) {
  return ProviderScope(
    overrides: [
      crowdForecastRepositoryMockProvider.overrideWithValue(
        _FakeCrowdRepo(forecast),
      ),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: CrowdForecastSection(placeId: 'spot-test'),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('예측이 있으면 제목·날짜 카드·범례를 표시한다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_host(_seriesFromToday()));
    await tester.pumpAndSettle();

    expect(find.text('예측 혼잡도'), findsOneWidget);
    expect(find.text('예측'), findsWidgets); // 신선도 pill
    expect(find.text('오늘'), findsOneWidget); // 날짜 카드
    expect(find.text('내일'), findsOneWidget);
    // 범례 + 배지에 레벨 텍스트가 노출된다.
    expect(find.text('여유'), findsWidgets);
    expect(find.text('보통'), findsWidgets);
    expect(find.text('혼잡'), findsWidgets);
  });

  testWidgets('예측이 없으면 섹션을 감춘다', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_host(CrowdForecast.empty));
    await tester.pumpAndSettle();

    expect(find.text('예측 혼잡도'), findsNothing);
  });
}
