import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/core/location/location_provider.dart'
    show locationServiceProvider;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_filters.dart'
    show NearbyFilters;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_search_origin.dart'
    show NearbySearchOrigin;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository.dart'
    show NearbyRepository;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository_supabase.dart'
    show NearbyRepositorySupabase;

part 'nearby_provider.g.dart';

/// '내 주변' 데이터 소스. 기본은 Supabase 구현체.
///
/// 테스트나 Mock 데모에서는 [NearbyRepositoryMock]으로
/// `overrideWithValue` 해서 교체한다.
@riverpod
NearbyRepository nearbyRepository(Ref ref) =>
    NearbyRepositorySupabase(Supabase.instance.client);

/// 검색 기준 좌표.
///
/// 위치 권한이 허용되어 현재 위치를 얻을 수 있으면 실제 좌표,
/// 아니면 [NearbySearchOrigin.fallback] (수원화성 대표 좌표)을 반환한다.
@riverpod
Future<NearbySearchOrigin> nearbySearchOrigin(Ref ref) async {
  final service = ref.read(locationServiceProvider);
  final position = await service.getCurrentPositionAsync();
  if (position != null) {
    return NearbySearchOrigin(
      lat: position.latitude,
      lng: position.longitude,
      isFallback: false,
    );
  }
  return NearbySearchOrigin.fallback;
}

/// 사용자가 UI에서 선택한 필터/정렬 상태.
///
/// 필터 바텀시트는 이 컨트롤러의 메서드를 호출하고, `nearbyPlacesProvider`가
/// 이 상태를 watch해서 필터 변화 시 자동으로 재조회한다.
@riverpod
class NearbyFiltersController extends _$NearbyFiltersController {
  @override
  NearbyFilters build() => const NearbyFilters();

  void setRadius(int radiusM) {
    if (state.radiusM == radiusM) return;
    state = state.copyWith(radiusM: radiusM);
  }

  void setSortBy(NearbySortBy sortBy) {
    if (state.sortBy == sortBy) return;
    state = state.copyWith(sortBy: sortBy);
  }

  /// [level]이 이미 선택되어 있으면 제거, 아니면 추가한다.
  void toggleCrowdLevel(String level) {
    final next = <String>{...state.crowdLevels};
    if (!next.remove(level)) next.add(level);
    state = state.copyWith(crowdLevels: next);
  }

  void reset() {
    state = const NearbyFilters();
  }
}

/// 검색 기준 좌표 + 사용자 필터를 조합해 반경 내 스팟을 조회한다.
///
/// [nearbySearchOriginProvider]와 [nearbyFiltersControllerProvider]를 watch하므로
/// 좌표나 필터가 갱신되면 자동으로 재조회한다.
@riverpod
Future<List<NearbyPlace>> nearbyPlaces(Ref ref) async {
  final origin = await ref.watch(nearbySearchOriginProvider.future);
  final filters = ref.watch(nearbyFiltersControllerProvider);
  return ref
      .read(nearbyRepositoryProvider)
      .fetchNearbyPlacesAsync(
        lat: origin.lat,
        lng: origin.lng,
        radiusM: filters.radiusM,
        sortBy: filters.sortBy,
        crowdLevels: filters.crowdLevels,
      );
}
