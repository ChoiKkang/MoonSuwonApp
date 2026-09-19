import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowd_forecast.freezed.dart';
part 'crowd_forecast.g.dart';

/// 하루치 예측 혼잡도.
///
/// 한국관광공사 관광지 혼잡도 "예측"이라 날짜 단위(시간대 아님)이며,
/// [level]은 '여유'/'보통'/'혼잡'(rate<40/<70/그 외). [score]는 0~100 예측치.
@freezed
abstract class DailyCrowd with _$DailyCrowd {
  const DailyCrowd._();

  const factory DailyCrowd({
    required String date,
    @Default('unknown') String level,
    double? score,
    @Default('unknown') String dataStatus,
  }) = _DailyCrowd;

  factory DailyCrowd.fromJson(Map<String, dynamic> json) =>
      _$DailyCrowdFromJson(json);

  bool get isStale => dataStatus == 'stale';

  /// 막대 높이용 0~100. score가 없으면 레벨로 근사한다.
  double get normalizedScore {
    if (score != null) return score!.clamp(0, 100).toDouble();
    switch (level) {
      case '혼잡':
      case '붐빔':
        return 85;
      case '보통':
        return 55;
      case '여유':
        return 25;
      default:
        return 0;
    }
  }
}

/// 장소의 날짜별 예측 혼잡도 시리즈(오늘부터 가까운 순).
@freezed
abstract class CrowdForecast with _$CrowdForecast {
  const CrowdForecast._();

  const factory CrowdForecast({
    @Default(<DailyCrowd>[]) List<DailyCrowd> days,
  }) = _CrowdForecast;

  factory CrowdForecast.fromJson(Map<String, dynamic> json) =>
      _$CrowdForecastFromJson(json);

  static const empty = CrowdForecast();

  /// 표시할 날짜 예측이 하나라도 있는지.
  bool get available => days.isNotEmpty;

  /// 모든 날이 오래된 데이터면 "지연"으로 본다.
  bool get isStale => days.isNotEmpty && days.every((d) => d.isStale);

  /// 첫 항목(오늘 또는 가장 가까운 예측일).
  DailyCrowd? get today => days.isEmpty ? null : days.first;
}
