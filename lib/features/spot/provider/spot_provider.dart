import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/core/location/location_provider.dart'
    show locationServiceProvider;
import 'package:dalbit_suwon/features/spot/data/spot_repository.dart'
    show SpotRepository;
import 'package:dalbit_suwon/features/spot/data/spot_repository_mock.dart'
    show SpotRepositoryMock;
import 'package:dalbit_suwon/features/spot/data/spot_repository_supabase.dart'
    show SpotRepositorySupabase;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;

part 'spot_provider.g.dart';

@riverpod
SpotRepository spotRepository(Ref ref) => SpotRepositoryMock();

@riverpod
SpotRepositorySupabase spotRepositorySupabase(Ref ref) =>
    SpotRepositorySupabase(Supabase.instance.client);

@riverpod
Future<SpotDetail> spotDetail(Ref ref, String spotId) {
  final repository = spotId.startsWith('spot-')
      ? ref.read(spotRepositoryProvider)
      : ref.read(spotRepositorySupabaseProvider);
  return repository.fetchSpotDetailAsync(spotId);
}

/// 위치 권한이 허용되어 있으면 현재 좌표를 함께 전달해 거리 가중치가
/// 반영되게 하고, 권한이 없으면 좌표 없이(야간 적합도/혼잡도만으로) 조회한다.
@riverpod
Future<List<SpotSummary>> nowGoodSpots(Ref ref) async {
  final position = await ref
      .read(locationServiceProvider)
      .getCurrentPositionAsync();
  return ref
      .read(spotRepositorySupabaseProvider)
      .fetchNowGoodSpotsAsync(lat: position?.latitude, lng: position?.longitude);
}
