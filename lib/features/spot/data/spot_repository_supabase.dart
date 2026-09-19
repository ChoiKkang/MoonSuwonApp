import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts;
import 'package:dalbit_suwon/features/spot/data/models/audio_story.dart'
    show AudioStory;
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

    // access_*/audio_stories는 이제 get_place_by_slug RPC가 함께 반환한다
    // (마이그레이션 20260919280000). RPC가 값을 주면 단일 RPC로 끝내고, 아직
    // 마이그레이션 적용 전이라 비어 있으면 공개 뷰로 폴백해 무중단으로 동작한다.
    var accessibility = place.accessibility;
    var audioStories = place.audioStories;
    if (!accessibility.hasInfo) {
      accessibility = await _fetchAccessibilityAsync(place.id);
    }
    if (audioStories.isEmpty) {
      audioStories = await _fetchAudioStoriesAsync(place.id);
    }

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
      accessibility: accessibility,
      audioStories: audioStories,
    );
  }

  /// 무장애(접근성) 정보를 공개 뷰 `v_published_places`에서 읽는다.
  /// 웹(`getPublishedPlaceBySlug`)이 쓰는 access_* 컬럼과 동일하다.
  Future<AccessibilityFacts> _fetchAccessibilityAsync(String placeId) async {
    try {
      final row = await _client
          .from('v_published_places')
          .select(
            'access_route, access_exit, access_elevator, access_parking, '
            'access_public_transport, access_wheelchair, access_braille_block, '
            'access_braille_promotion, access_audio_guide, access_big_print, '
            'access_help_dog, access_restroom, access_lactation_room, '
            'access_stroller, access_infants_family, access_etc, '
            'access_source_updated_at',
          )
          .eq('id', placeId)
          .maybeSingle();
      if (row == null) return const AccessibilityFacts();
      final m = Map<String, dynamic>.from(row);
      return AccessibilityFacts(
        route: m['access_route'] as String?,
        exit: m['access_exit'] as String?,
        elevator: m['access_elevator'] as String?,
        parking: m['access_parking'] as String?,
        publicTransport: m['access_public_transport'] as String?,
        wheelchair: m['access_wheelchair'] as String?,
        brailleBlock: m['access_braille_block'] as String?,
        braillePromotion: m['access_braille_promotion'] as String?,
        audioGuide: m['access_audio_guide'] as String?,
        bigPrint: m['access_big_print'] as String?,
        helpDog: m['access_help_dog'] as String?,
        restroom: m['access_restroom'] as String?,
        lactationRoom: m['access_lactation_room'] as String?,
        stroller: m['access_stroller'] as String?,
        infantsFamily: m['access_infants_family'] as String?,
        etc: m['access_etc'] as String?,
        sourceUpdatedAt: m['access_source_updated_at'] as String?,
      );
    } catch (_) {
      return const AccessibilityFacts();
    }
  }

  /// 오디오 해설을 공개 뷰 `v_published_place_audio_stories`에서 읽는다(가까운 순).
  Future<List<AudioStory>> _fetchAudioStoriesAsync(String placeId) async {
    try {
      final rows = await _client
          .from('v_published_place_audio_stories')
          .select(
            'story_lang_id, spot_title, audio_title, script, '
            'play_seconds, audio_url, distance_m',
          )
          .eq('place_id', placeId)
          .order('distance_m', ascending: true);
      return (rows as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .map(
            (m) => AudioStory(
              id: m['story_lang_id'] as String? ?? '',
              spotTitle: (m['spot_title'] as String?)?.trim(),
              audioTitle: (m['audio_title'] as String? ?? '').trim(),
              script: (m['script'] as String?)?.trim(),
              playSeconds: (m['play_seconds'] as num?)?.toInt(),
              audioUrl: (m['audio_url'] as String?)?.trim(),
              distanceM: (m['distance_m'] as num?)?.toInt(),
            ),
          )
          .where((s) => s.id.isNotEmpty && s.audioTitle.isNotEmpty)
          .toList();
    } catch (_) {
      return const [];
    }
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
