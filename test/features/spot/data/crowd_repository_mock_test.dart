import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/crowd_repository_mock.dart'
    show CrowdForecastRepositoryMock;

void main() {
  const repo = CrowdForecastRepositoryMock();

  test('오늘부터 날짜별 예측 시리즈를 fresh로 반환한다', () async {
    final forecast = await repo.fetchCrowdForecastAsync(
      'spot-banghwasuryujeong',
    );

    expect(forecast.available, isTrue);
    expect(forecast.days, isNotEmpty);
    // 방화수류정 첫날은 혼잡.
    expect(forecast.today?.level, '혼잡');
    // 날짜 오름차순.
    final dates = forecast.days.map((d) => d.date).toList();
    final sorted = [...dates]..sort();
    expect(dates, sorted);
    for (final d in forecast.days) {
      expect(['여유', '보통', '혼잡'].contains(d.level), isTrue);
      expect(d.dataStatus, 'fresh');
      expect(d.normalizedScore, inInclusiveRange(0, 100));
    }
  });

  test('알 수 없는 장소도 기본 시리즈를 제공한다', () async {
    final forecast = await repo.fetchCrowdForecastAsync('spot-unknown-xyz');
    expect(forecast.available, isTrue);
    expect(forecast.today?.level, '보통');
  });
}
