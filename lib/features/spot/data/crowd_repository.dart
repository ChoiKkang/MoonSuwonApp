import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast;

/// 장소의 날짜별 예측 혼잡도를 조회한다.
///
/// 실시간이 아니라 예측이라 구현체는 신선도(dataStatus)를 함께 채운다.
/// 데이터가 없으면 예외를 던지지 않고 빈 [CrowdForecast]를 돌려준다.
abstract class CrowdForecastRepository {
  Future<CrowdForecast> fetchCrowdForecastAsync(String placeId);
}
