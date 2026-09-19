import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/crowd_repository.dart'
    show CrowdForecastRepository;
import 'package:dalbit_suwon/features/spot/data/models/crowd_forecast.dart'
    show CrowdForecast, DailyCrowd;

/// Supabase `public.get_place_crowd_forecast(p_place_id)` RPC로 날짜별 예측을 읽는다.
///
/// RPC가 아직 없거나(마이그레이션 미적용) 오류일 때는 예외를 던지지 않고 빈
/// [CrowdForecast]를 돌려준다(앱은 섹션을 감춤).
class CrowdForecastRepositorySupabase implements CrowdForecastRepository {
  const CrowdForecastRepositorySupabase(this._client);

  final SupabaseClient _client;

  @override
  Future<CrowdForecast> fetchCrowdForecastAsync(String placeId) async {
    try {
      final rows =
          await _client.rpc(
                'get_place_crowd_forecast',
                params: {'p_place_id': placeId},
              )
              as List<dynamic>;
      final days = rows
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map(
            (m) => DailyCrowd(
              date: m['forecast_date'] as String? ?? '',
              level: m['crowd_level'] as String? ?? 'unknown',
              score: (m['forecast_score'] as num?)?.toDouble(),
              dataStatus: m['data_status'] as String? ?? 'unknown',
            ),
          )
          .where((d) => d.date.isNotEmpty)
          .toList();
      return CrowdForecast(days: days);
    } catch (_) {
      return CrowdForecast.empty;
    }
  }
}
