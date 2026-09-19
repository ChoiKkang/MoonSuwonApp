import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast, DailyCrowd;

void main() {
  group('DailyCrowd.normalizedScore', () {
    test('score가 있으면 0~100 클램프', () {
      expect(const DailyCrowd(date: 'd', level: '혼잡', score: 82).normalizedScore, 82);
      expect(const DailyCrowd(date: 'd', level: '혼잡', score: 140).normalizedScore, 100);
    });
    test('score가 없으면 레벨로 근사', () {
      expect(const DailyCrowd(date: 'd', level: '혼잡').normalizedScore, 85);
      expect(const DailyCrowd(date: 'd', level: '보통').normalizedScore, 55);
      expect(const DailyCrowd(date: 'd', level: '여유').normalizedScore, 25);
      expect(const DailyCrowd(date: 'd', level: 'unknown').normalizedScore, 0);
    });
  });

  group('CrowdForecast', () {
    test('빈 시리즈는 available=false', () {
      expect(CrowdForecast.empty.available, isFalse);
      expect(CrowdForecast.empty.today, isNull);
    });

    test('날짜가 있으면 available=true, today=첫 항목', () {
      const f = CrowdForecast(
        days: [
          DailyCrowd(date: '2026-09-19', level: '보통', score: 55, dataStatus: 'fresh'),
          DailyCrowd(date: '2026-09-20', level: '여유', score: 30, dataStatus: 'fresh'),
        ],
      );
      expect(f.available, isTrue);
      expect(f.today?.date, '2026-09-19');
      expect(f.isStale, isFalse);
    });

    test('모든 날이 stale이면 isStale=true', () {
      const f = CrowdForecast(
        days: [
          DailyCrowd(date: '2026-09-19', level: '보통', dataStatus: 'stale'),
          DailyCrowd(date: '2026-09-20', level: '여유', dataStatus: 'stale'),
        ],
      );
      expect(f.isStale, isTrue);
      expect(f.available, isTrue);
    });
  });
}
