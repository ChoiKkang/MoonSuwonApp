import 'package:dalbit_suwon/features/spot/data/crowd_repository.dart'
    show CrowdForecastRepository;
import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast, DailyCrowd;

/// 로컬(Mock) 날짜별 예측 혼잡도.
///
/// 오늘부터 3일치를 스팟별로 레벨만 달리해 생성한다. 실제 서비스에서는
/// get_place_crowd_forecast RPC(core.place_crowd_forecasts, 일별)로 대체된다.
class CrowdForecastRepositoryMock implements CrowdForecastRepository {
  const CrowdForecastRepositoryMock();

  static const _levelsBySpot = <String, List<String>>{
    'spot-banghwasuryujeong': ['혼잡', '보통', '여유'],
    'spot-hwaseonghaenggung': ['보통', '보통', '여유'],
    'spot-yongyeon': ['여유', '여유', '여유'],
    'spot-haengridangil': ['혼잡', '혼잡', '보통'],
  };

  @override
  Future<CrowdForecast> fetchCrowdForecastAsync(String placeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final levels = _levelsBySpot[placeId] ?? const ['보통', '여유', '여유'];
    final today = DateTime.now();
    final base = DateTime(today.year, today.month, today.day);
    final days = <DailyCrowd>[
      for (var i = 0; i < levels.length; i++)
        DailyCrowd(
          date: _fmtDate(base.add(Duration(days: i))),
          level: levels[i],
          score: _scoreFor(levels[i]),
          dataStatus: 'fresh',
        ),
    ];
    return CrowdForecast(days: days);
  }

  static String _fmtDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  double _scoreFor(String level) {
    switch (level) {
      case '혼잡':
        return 82;
      case '보통':
        return 55;
      default:
        return 28;
    }
  }
}
