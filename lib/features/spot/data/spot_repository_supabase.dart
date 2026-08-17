import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/models/now_good_spot_dto.dart'
    show NowGoodSpotDto;
import 'package:dalbit_suwon/features/spot/data/models/now_good_spots_query_dto.dart'
    show NowGoodSpotsQueryDto;
import 'package:dalbit_suwon/features/spot/data/models/place_by_slug_dto.dart'
    show PlaceBySlugDto, PlaceBySlugQueryDto;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/data/spot_repository.dart'
    show NowGoodSpotsRepository, SpotRepository;

class SpotRepositorySupabase implements SpotRepository, NowGoodSpotsRepository {
  const SpotRepositorySupabase(this._client);

  final SupabaseClient _client;

  @override
  Future<SpotDetail> fetchSpotDetailAsync(String slug) async {
    final query = PlaceBySlugQueryDto(slug);
    final row =
        await _client.rpc('get_place_by_slug', params: query.toJson()) as Map;
    final place = PlaceBySlugDto.fromJson(Map<String, dynamic>.from(row));

    return SpotDetail(
      id: place.id,
      name: place.displayName,
      category: place.category ?? 'heritage-night-view',
      intro: _firstNonEmpty([
        place.shortDescription,
        place.shortStory,
        place.officialName,
      ]),
      heroImageUrl: place.heroImageUrl,
      lat: place.lat,
      lng: place.lng,
      nightHighlight: place.nightHighlight ?? '',
      photoTip: place.photoTip ?? '',
      romanticMoment: place.coupleQuestion ?? '',
      missionPrompt: place.missionPrompt ?? '',
      missionRadiusM: place.missionRadiusM,
      nearbySpots: const [],
    );
  }

  @override
  Future<List<SpotSummary>> fetchNowGoodSpotsAsync() async {
    const query = NowGoodSpotsQueryDto();
    final rows =
        await _client.rpc('get_now_good_spots', params: query.toJson())
            as List<dynamic>;

    return rows
        .map(
          (row) =>
              NowGoodSpotDto.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .map(
          (spot) => SpotSummary(
            id: spot.placeId,
            slug: spot.slug,
            name: spot.displayName,
            category: 'heritage-night-view',
            heroImageUrl: spot.heroImageUrl,
            crowdLevel: spot.crowdLevel,
            distanceM: spot.distanceM,
            reasonLabel: spot.reasonLabel,
            recommendationScore: spot.recommendationScore,
            forecastStatus: spot.forecastStatus,
          ),
        )
        .toList();
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value;
    }
    return '';
  }
}
