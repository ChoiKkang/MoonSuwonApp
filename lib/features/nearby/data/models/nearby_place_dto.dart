/// Supabase RPC `public.get_nearby_places` 응답 row 1건.
///
/// 반환 컬럼: id, slug, official_name, lat, lng, category, display_name,
/// night_highlight, hero_image_url, distance_m, crowd_level, recommendation_score,
/// night_suitability_score, forecast_status.
class NearbyPlaceDto {
  const NearbyPlaceDto({
    required this.id,
    required this.slug,
    required this.officialName,
    required this.displayName,
    required this.lat,
    required this.lng,
    required this.distanceM,
    required this.forecastStatus,
    this.category,
    this.nightHighlight,
    this.heroImageUrl,
    this.crowdLevel,
    this.recommendationScore,
    this.nightSuitabilityScore,
  });

  factory NearbyPlaceDto.fromJson(Map<String, dynamic> json) {
    return NearbyPlaceDto(
      id: json['id'] as String,
      slug: json['slug'] as String,
      officialName: json['official_name'] as String,
      displayName:
          (json['display_name'] as String?) ?? (json['official_name'] as String),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      distanceM: (json['distance_m'] as num).toDouble(),
      category: json['category'] as String?,
      nightHighlight: json['night_highlight'] as String?,
      heroImageUrl: json['hero_image_url'] as String?,
      crowdLevel: json['crowd_level'] as String?,
      recommendationScore: (json['recommendation_score'] as num?)?.toDouble(),
      nightSuitabilityScore: (json['night_suitability_score'] as num?)
          ?.toDouble(),
      forecastStatus:
          json['forecast_status'] as String? ?? 'forecast_unavailable',
    );
  }

  final String id;
  final String slug;
  final String officialName;
  final String displayName;
  final double lat;
  final double lng;
  final double distanceM;
  final String? category;
  final String? nightHighlight;
  final String? heroImageUrl;
  final String? crowdLevel;
  final double? recommendationScore;
  final double? nightSuitabilityScore;
  final String forecastStatus;
}
