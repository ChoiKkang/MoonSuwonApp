class NowGoodSpotDto {
  const NowGoodSpotDto({
    required this.placeId,
    required this.slug,
    required this.displayName,
    required this.heroImageUrl,
    required this.crowdLevel,
    required this.distanceM,
    required this.reasonLabel,
    required this.recommendationScore,
    required this.forecastStatus,
  });

  factory NowGoodSpotDto.fromJson(Map<String, dynamic> json) {
    return NowGoodSpotDto(
      placeId: json['place_id'] as String,
      slug: json['slug'] as String,
      displayName: json['display_name'] as String,
      heroImageUrl: json['hero_image_url'] as String,
      crowdLevel: json['crowd_level'] as String?,
      distanceM: (json['distance_m'] as num?)?.toDouble(),
      reasonLabel: json['reason_label'] as String,
      recommendationScore: (json['recommendation_score'] as num).toDouble(),
      forecastStatus: json['forecast_status'] as String,
    );
  }

  final String placeId;
  final String slug;
  final String displayName;
  final String heroImageUrl;
  final String? crowdLevel;
  final double? distanceM;
  final String reasonLabel;
  final double recommendationScore;
  final String forecastStatus;
}
