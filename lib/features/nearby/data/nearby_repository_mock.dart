import 'dart:math' as math;

import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository.dart'
    show NearbyRepository;

/// Mock 구현체. 수원화성 대표 스팟 8개를 하드코딩하고
/// 요청 좌표 기준 거리로 정렬해 반환한다.
///
/// Supabase 연동이 되지 않은 환경(테스트, 오프라인 데모)에서 UI를 검증할 때 사용.
class NearbyRepositoryMock implements NearbyRepository {
  const NearbyRepositoryMock();

  static const _seed = <NearbyPlace>[
    NearbyPlace(
      id: 'mock-banghwasuryujeong',
      slug: 'banghwasuryujeong',
      officialName: '방화수류정',
      displayName: '방화수류정',
      lat: 37.2870,
      lng: 127.0175,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '수면 반사와 정자 조명이 함께 보이는 구간',
      heroImageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47',
      crowdLevel: '여유',
      recommendationScore: 92,
      nightSuitabilityScore: 95,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-yongyeon',
      slug: 'yongyeon',
      officialName: '용연',
      displayName: '용연',
      lat: 37.2885,
      lng: 127.0168,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '달빛이 수면에 반사되는 잔잔한 연못',
      forecastStatus: 'forecast_unavailable',
      nightSuitabilityScore: 78,
      recommendationScore: 70,
    ),
    NearbyPlace(
      id: 'mock-hwahongmun',
      slug: 'hwahongmun',
      officialName: '화홍문',
      displayName: '화홍문',
      lat: 37.2891,
      lng: 127.0197,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '수원천 위 무지개 다리의 야간 라이트업',
      crowdLevel: '보통',
      recommendationScore: 84,
      nightSuitabilityScore: 86,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-hwaseonghaenggung',
      slug: 'hwaseong-haenggung',
      officialName: '화성행궁',
      displayName: '화성행궁',
      lat: 37.2836,
      lng: 127.0135,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '조선 최대 규모 행궁의 야간 조명',
      crowdLevel: '혼잡',
      recommendationScore: 76,
      nightSuitabilityScore: 88,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-janganmun',
      slug: 'janganmun',
      officialName: '장안문',
      displayName: '장안문',
      lat: 37.2896,
      lng: 127.0147,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '수원화성 북쪽 정문의 웅장한 야경',
      crowdLevel: '여유',
      recommendationScore: 88,
      nightSuitabilityScore: 92,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-changryongmun',
      slug: 'changryongmun',
      officialName: '창룡문',
      displayName: '창룡문',
      lat: 37.2843,
      lng: 127.0219,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '동쪽 성문에서 바라보는 성곽 라인',
      crowdLevel: '여유',
      recommendationScore: 82,
      nightSuitabilityScore: 90,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-yeonmudae',
      slug: 'yeonmudae',
      officialName: '연무대',
      displayName: '연무대',
      lat: 37.2862,
      lng: 127.0221,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '조명이 밝은 광장과 국궁 체험 공간',
      crowdLevel: '보통',
      recommendationScore: 80,
      nightSuitabilityScore: 94,
      forecastStatus: 'forecast_available',
    ),
    NearbyPlace(
      id: 'mock-seojangdae',
      slug: 'seojangdae',
      officialName: '서장대',
      displayName: '효원의 종·서장대',
      lat: 37.2865,
      lng: 127.0101,
      distanceM: 0,
      category: 'heritage-night-view',
      nightHighlight: '수원 시내를 한눈에 담는 팔달산 야경 뷰',
      crowdLevel: '여유',
      recommendationScore: 78,
      nightSuitabilityScore: 84,
      forecastStatus: 'forecast_available',
    ),
  ];

  @override
  Future<List<NearbyPlace>> fetchNearbyPlacesAsync({
    required double lat,
    required double lng,
    int radiusM = 3000,
    NearbySortBy sortBy = NearbySortBy.distance,
    Set<String> crowdLevels = const <String>{},
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final withDistance = _seed
        .map(
          (place) => NearbyPlace(
            id: place.id,
            slug: place.slug,
            officialName: place.officialName,
            displayName: place.displayName,
            lat: place.lat,
            lng: place.lng,
            distanceM: _haversineMeters(
              lat1: lat,
              lng1: lng,
              lat2: place.lat,
              lng2: place.lng,
            ),
            category: place.category,
            nightHighlight: place.nightHighlight,
            heroImageUrl: place.heroImageUrl,
            crowdLevel: place.crowdLevel,
            recommendationScore: place.recommendationScore,
            nightSuitabilityScore: place.nightSuitabilityScore,
            forecastStatus: place.forecastStatus,
          ),
        )
        .where((place) => place.distanceM <= radiusM)
        .where(
          (place) =>
              crowdLevels.isEmpty ||
              (place.hasForecast && crowdLevels.contains(place.crowdLevel)),
        )
        .toList();

    switch (sortBy) {
      case NearbySortBy.distance:
        withDistance.sort((a, b) => a.distanceM.compareTo(b.distanceM));
      case NearbySortBy.recommendation:
        withDistance.sort(
          (a, b) => (b.recommendationScore ?? 0).compareTo(
            a.recommendationScore ?? 0,
          ),
        );
      case NearbySortBy.nightSuitability:
        withDistance.sort(
          (a, b) => (b.nightSuitabilityScore ?? 0).compareTo(
            a.nightSuitabilityScore ?? 0,
          ),
        );
    }
    return withDistance;
  }

  /// 실제 RPC는 PostGIS `ST_Distance`를 쓰지만, mock은 하버사인 근사로 충분하다.
  static double _haversineMeters({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    const earthRadiusM = 6371000.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLng = _degToRad(lng2 - lng1);
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) *
            math.cos(_degToRad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusM * c;
  }

  static double _degToRad(double deg) => deg * (math.pi / 180.0);
}
