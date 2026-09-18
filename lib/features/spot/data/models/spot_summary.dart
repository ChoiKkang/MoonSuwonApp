import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_summary.freezed.dart';
part 'spot_summary.g.dart';

@freezed
abstract class SpotSummary with _$SpotSummary {
  const factory SpotSummary({
    required String id,
    required String slug,
    required String name,
    required String category,
    required String heroImageUrl,
    String? crowdLevel,
    double? distanceM,
    required String reasonLabel,
    required double recommendationScore,
    required String forecastStatus,
  }) = _SpotSummary;

  factory SpotSummary.fromJson(Map<String, dynamic> json) =>
      _$SpotSummaryFromJson(json);
}
