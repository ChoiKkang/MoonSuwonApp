import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/crowd_repository.dart'
    show CrowdForecastRepository;
import 'package:dalbit_suwon/features/spot/data/crowd_repository_mock.dart'
    show CrowdForecastRepositoryMock;
import 'package:dalbit_suwon/features/spot/data/crowd_repository_supabase.dart'
    show CrowdForecastRepositorySupabase;
import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast;

part 'crowd_provider.g.dart';

@riverpod
CrowdForecastRepository crowdForecastRepositoryMock(Ref ref) =>
    const CrowdForecastRepositoryMock();

@riverpod
CrowdForecastRepository crowdForecastRepositorySupabase(Ref ref) =>
    CrowdForecastRepositorySupabase(Supabase.instance.client);

/// 장소의 날짜별 예측 혼잡도.
///
/// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
/// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.
@riverpod
Future<CrowdForecast> crowdForecast(Ref ref, String placeId) {
  final repository = placeId.startsWith('spot-')
      ? ref.read(crowdForecastRepositoryMockProvider)
      : ref.read(crowdForecastRepositorySupabaseProvider);
  return repository.fetchCrowdForecastAsync(placeId);
}
