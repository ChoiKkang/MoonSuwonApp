import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

@riverpod
Future<List<SpotSummary>> nowGoodSpots(Ref ref) =>
    ref.read(spotRepositorySupabaseProvider).fetchNowGoodSpotsAsync();
