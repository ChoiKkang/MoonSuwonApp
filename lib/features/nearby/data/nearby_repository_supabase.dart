import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_place_dto.dart'
    show NearbyPlaceDto;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_places_query_dto.dart'
    show NearbyPlacesQueryDto;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository.dart'
    show NearbyRepository;

/// Supabase `public.get_nearby_places` RPC를 호출하는 Repository 구현체.
///
/// RPC 시그니처:
///   get_nearby_places(p_lat, p_lng, p_radius_m, p_sort_by text,
///                     p_crowd_levels text[])
/// 반환 컬럼: id, slug, official_name, lat, lng, category, display_name,
/// night_highlight, hero_image_url, distance_m, crowd_level, recommendation_score,
/// night_suitability_score, forecast_status.
class NearbyRepositorySupabase implements NearbyRepository {
  const NearbyRepositorySupabase(this._client);

  final SupabaseClient _client;

  @override
  Future<List<NearbyPlace>> fetchNearbyPlacesAsync({
    required double lat,
    required double lng,
    int radiusM = 3000,
    NearbySortBy sortBy = NearbySortBy.distance,
    Set<String> crowdLevels = const <String>{},
  }) async {
    final query = NearbyPlacesQueryDto(
      lat: lat,
      lng: lng,
      radiusM: radiusM,
      sortBy: sortBy,
      crowdLevels: crowdLevels,
    );
    final rows =
        await _client.rpc('get_nearby_places', params: query.toJson())
            as List<dynamic>;

    return rows
        .map(
          (row) =>
              NearbyPlaceDto.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .map(
          (dto) => NearbyPlace(
            id: dto.id,
            slug: dto.slug,
            officialName: dto.officialName,
            displayName: dto.displayName,
            lat: dto.lat,
            lng: dto.lng,
            distanceM: dto.distanceM,
            category: dto.category,
            nightHighlight: dto.nightHighlight,
            heroImageUrl: dto.heroImageUrl,
            crowdLevel: dto.crowdLevel,
            recommendationScore: dto.recommendationScore,
            nightSuitabilityScore: dto.nightSuitabilityScore,
            forecastStatus: dto.forecastStatus,
          ),
        )
        .toList();
  }
}
