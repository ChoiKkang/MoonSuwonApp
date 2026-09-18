import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_search_origin.dart'
    show NearbySearchOrigin;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository.dart'
    show NearbyRepository;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show
        nearbyFiltersControllerProvider,
        nearbyPlacesProvider,
        nearbyRepositoryProvider,
        nearbySearchOriginProvider;

void main() {
  test('필터 기본값이면 origin 좌표 + radius 3km + distance 정렬로 호출한다', () async {
    final repo = _FakeNearbyRepository();
    final container = ProviderContainer(
      overrides: [
        nearbyRepositoryProvider.overrideWithValue(repo),
        nearbySearchOriginProvider.overrideWith(
          (ref) async => const NearbySearchOrigin(
            lat: 37.29,
            lng: 127.02,
            isFallback: false,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(nearbyPlacesProvider.future);

    expect(repo.lastLat, 37.29);
    expect(repo.lastLng, 127.02);
    expect(repo.lastRadiusM, 3000);
    expect(repo.lastSortBy, NearbySortBy.distance);
    expect(repo.lastCrowdLevels, isEmpty);
    expect(result, hasLength(1));
    expect(result.single.slug, 'banghwasuryujeong');
  });

  test('origin이 fallback을 반환하면 fallback 좌표로 조회한다', () async {
    final repo = _FakeNearbyRepository();
    final container = ProviderContainer(
      overrides: [
        nearbyRepositoryProvider.overrideWithValue(repo),
        nearbySearchOriginProvider.overrideWith(
          (ref) async => NearbySearchOrigin.fallback,
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(nearbyPlacesProvider.future);

    expect(repo.lastLat, 37.28617);
    expect(repo.lastLng, 127.01203);
  });

  test('필터 컨트롤러가 상태를 바꾸면 nearbyPlacesProvider가 새 파라미터로 재조회한다', () async {
    final repo = _FakeNearbyRepository();
    final container = ProviderContainer(
      overrides: [
        nearbyRepositoryProvider.overrideWithValue(repo),
        nearbySearchOriginProvider.overrideWith(
          (ref) async => NearbySearchOrigin.fallback,
        ),
      ],
    );
    addTearDown(container.dispose);

    // 초기 호출 — 기본값.
    await container.read(nearbyPlacesProvider.future);
    expect(repo.callCount, 1);
    expect(repo.lastRadiusM, 3000);
    expect(repo.lastCrowdLevels, isEmpty);

    // 반경 축소.
    container
        .read(nearbyFiltersControllerProvider.notifier)
        .setRadius(500);
    await container.read(nearbyPlacesProvider.future);
    expect(repo.callCount, 2);
    expect(repo.lastRadiusM, 500);

    // 혼잡도 여유 토글.
    container
        .read(nearbyFiltersControllerProvider.notifier)
        .toggleCrowdLevel('여유');
    await container.read(nearbyPlacesProvider.future);
    expect(repo.callCount, 3);
    expect(repo.lastCrowdLevels, {'여유'});

    // 정렬 변경.
    container
        .read(nearbyFiltersControllerProvider.notifier)
        .setSortBy(NearbySortBy.recommendation);
    await container.read(nearbyPlacesProvider.future);
    expect(repo.callCount, 4);
    expect(repo.lastSortBy, NearbySortBy.recommendation);

    // 초기화.
    container.read(nearbyFiltersControllerProvider.notifier).reset();
    await container.read(nearbyPlacesProvider.future);
    expect(repo.callCount, 5);
    expect(repo.lastRadiusM, 3000);
    expect(repo.lastSortBy, NearbySortBy.distance);
    expect(repo.lastCrowdLevels, isEmpty);
  });
}

class _FakeNearbyRepository implements NearbyRepository {
  double? lastLat;
  double? lastLng;
  int? lastRadiusM;
  NearbySortBy? lastSortBy;
  Set<String> lastCrowdLevels = const {};
  int callCount = 0;

  @override
  Future<List<NearbyPlace>> fetchNearbyPlacesAsync({
    required double lat,
    required double lng,
    int radiusM = 3000,
    NearbySortBy sortBy = NearbySortBy.distance,
    Set<String> crowdLevels = const <String>{},
  }) async {
    callCount += 1;
    lastLat = lat;
    lastLng = lng;
    lastRadiusM = radiusM;
    lastSortBy = sortBy;
    lastCrowdLevels = Set.of(crowdLevels);
    return const [
      NearbyPlace(
        id: 'fake-1',
        slug: 'banghwasuryujeong',
        officialName: '방화수류정',
        displayName: '방화수류정',
        lat: 37.2870,
        lng: 127.0175,
        distanceM: 128,
        category: 'heritage-night-view',
        nightHighlight: '수면 반사와 정자 조명이 함께 보이는 구간',
        crowdLevel: '여유',
        recommendationScore: 92,
        nightSuitabilityScore: 95,
        forecastStatus: 'forecast_available',
      ),
    ];
  }
}
