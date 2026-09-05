import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;

/// '내 주변' 탭 데이터를 조회하는 Repository 인터페이스.
///
/// Mock/Supabase 구현체가 이 계약을 공유한다. UI/Provider 계층은 구현체 대신
/// 이 인터페이스만 참조한다.
abstract class NearbyRepository {
  /// 현재 위치 기준 반경 내 공개 스팟을 정렬 규칙에 따라 반환한다.
  ///
  /// - [lat], [lng]: WGS84 좌표. 위치 권한이 없을 때는 수원화성 대표 좌표를 사용.
  /// - [radiusM]: 검색 반경(m). 3km가 MVP 기본값.
  /// - [sortBy]: 정렬 기준(거리·추천·야간 적합도).
  /// - [crowdLevels]: 허용 혼잡도 집합. 비어 있으면 필터링하지 않는다.
  Future<List<NearbyPlace>> fetchNearbyPlacesAsync({
    required double lat,
    required double lng,
    int radiusM = 3000,
    NearbySortBy sortBy = NearbySortBy.distance,
    Set<String> crowdLevels = const <String>{},
  });
}
