/// 내 주변 리스트에 노출되는 스팟 단위 데이터.
///
/// Supabase `public.get_nearby_places` RPC의 응답 필드를 정규화한 도메인 모델.
/// UI/Provider 계층은 이 모델만 참조하고, DB 필드명(snake_case)은 DTO에서 흡수한다.
class NearbyPlace {
  const NearbyPlace({
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

  /// core.places.id (UUID)
  final String id;

  /// core.places.slug — `/spot/:slug` 라우팅에 사용
  final String slug;

  /// core.places.official_name — 공공데이터 원본 명
  final String officialName;

  /// editorial.place_copy.display_name 있으면 그 값, 없으면 official_name
  final String displayName;

  /// 위도
  final double lat;

  /// 경도
  final double lng;

  /// 현재 위치와의 거리(m). PostGIS ST_Distance 결과.
  final double distanceM;

  /// core.places.category — 예: `heritage-night-view`
  final String? category;

  /// editorial.place_copy.night_highlight — 카드 서브 문구로 사용
  final String? nightHighlight;

  /// core.place_images WHERE is_hero=true 의 image_url
  final String? heroImageUrl;

  /// 오늘(KST) 예측 혼잡도. '여유' | '보통' | '혼잡'. 예측 없으면 null.
  final String? crowdLevel;

  /// 종합 추천 점수(0~100). 혼잡·야간·거리 가중 합 + 운영자 보정.
  final double? recommendationScore;

  /// editorial에서 운영하는 야간 적합도 점수(0~100).
  final double? nightSuitabilityScore;

  /// 혼잡 예측 데이터 존재 여부.
  /// - 'forecast_available': [crowdLevel]이 유효.
  /// - 'forecast_unavailable': [crowdLevel]이 null.
  final String forecastStatus;

  bool get hasForecast => forecastStatus == 'forecast_available';
}
