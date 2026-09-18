import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;

/// Supabase RPC `public.get_nearby_places(p_lat, p_lng, p_radius_m, p_sort_by, p_crowd_levels)` 요청 DTO.
///
/// 앱은 raw Map을 RPC에 직접 전달하지 않고, 이 DTO의 [toJson]으로 전달한다.
class NearbyPlacesQueryDto {
  const NearbyPlacesQueryDto({
    required this.lat,
    required this.lng,
    this.radiusM = 3000,
    this.sortBy = NearbySortBy.distance,
    this.crowdLevels = const <String>{},
  });

  /// 사용자의 현재 위도. 위치 권한이 없을 때는 수원화성 대표 좌표 사용.
  final double lat;

  /// 사용자의 현재 경도. 위치 권한이 없을 때는 수원화성 대표 좌표 사용.
  final double lng;

  /// 검색 반경(m). MVP 기본값은 3km (수원화성 성곽 반경 포함).
  final int radiusM;

  /// 정렬 방식. RPC의 `p_sort_by`로 wire 문자열이 전달된다.
  final NearbySortBy sortBy;

  /// 혼잡도 필터. 비어 있으면 필터링을 하지 않는다.
  final Set<String> crowdLevels;

  Map<String, dynamic> toJson() => {
    'p_lat': lat,
    'p_lng': lng,
    'p_radius_m': radiusM,
    'p_sort_by': sortBy.wire,
    'p_crowd_levels': crowdLevels.isEmpty ? null : crowdLevels.toList(),
  };
}
