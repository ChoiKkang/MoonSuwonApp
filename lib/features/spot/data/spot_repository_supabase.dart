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
    final row = await _client.rpc('get_place_by_slug', params: query.toJson());
    if (row == null) {
      throw StateError('스팟을 찾을 수 없습니다 (slug=$slug).');
    }
    final place = PlaceBySlugDto.fromJson(Map<String, dynamic>.from(row as Map));

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
      petPolicy: place.petPolicy ?? 'unknown',
      petNote: place.petNote ?? '',
      accessibility: place.accessibility,
      // 오디오 해설은 장소당 여러 건이라 평면 RPC가 아닌 별도 뷰에서 읽어야 한다.
      // 웹은 v_published_place_audio_stories(place_id 기준)를 조회한다. 앱에도
      // get_place_audio_stories RPC가 준비되면 여기서 채운다. 그전까지는 빈 목록.
      audioStories: const [],
    );
  }

  @override
  Future<List<SpotSummary>> fetchNowGoodSpotsAsync({
    double? lat,
    double? lng,
    int limit = 20,
  }) async {
    final query = NowGoodSpotsQueryDto(lat: lat, lng: lng, limit: limit);
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
