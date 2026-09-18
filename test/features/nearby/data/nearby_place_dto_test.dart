import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_place_dto.dart'
    show NearbyPlaceDto;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_places_query_dto.dart'
    show NearbyPlacesQueryDto;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;

void main() {
  group('NearbyPlacesQueryDto', () {
    test('기본값은 distance 정렬 + p_crowd_levels null 이다', () {
      const query = NearbyPlacesQueryDto(
        lat: 37.28617,
        lng: 127.01203,
        radiusM: 3000,
      );
      expect(query.toJson(), {
        'p_lat': 37.28617,
        'p_lng': 127.01203,
        'p_radius_m': 3000,
        'p_sort_by': 'distance',
        'p_crowd_levels': null,
      });
    });

    test('정렬을 지정하면 wire 문자열로 전송한다', () {
      const query = NearbyPlacesQueryDto(
        lat: 37.29,
        lng: 127.02,
        sortBy: NearbySortBy.recommendation,
      );
      expect(query.toJson()['p_sort_by'], 'recommendation');
    });

    test('혼잡도 필터가 있으면 배열로, 없으면 null 로 보낸다', () {
      const empty = NearbyPlacesQueryDto(lat: 37.28, lng: 127.01);
      expect(empty.toJson()['p_crowd_levels'], isNull);

      final withLevels = NearbyPlacesQueryDto(
        lat: 37.28,
        lng: 127.01,
        crowdLevels: {'여유', '보통'},
      );
      expect(
        (withLevels.toJson()['p_crowd_levels'] as List<dynamic>).toSet(),
        {'여유', '보통'},
      );
    });
  });

  group('NearbyPlaceDto.fromJson', () {
    test('RPC 응답 필드를 도메인 모델용 값으로 매핑한다', () {
      final dto = NearbyPlaceDto.fromJson({
        'id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
        'slug': 'banghwasuryujeong',
        'official_name': '방화수류정',
        'lat': 37.2870,
        'lng': 127.0175,
        'category': 'heritage-night-view',
        'display_name': '방화수류정(동북각루)',
        'night_highlight': '수면 반사와 정자 조명이 함께 보이는 구간',
        'hero_image_url': 'https://example.com/hero.jpg',
        'distance_m': 128.4,
        'crowd_level': '여유',
        'recommendation_score': 92.5,
        'night_suitability_score': 95.0,
        'forecast_status': 'forecast_available',
      });

      expect(dto.id, 'c2dd085a-dff6-40fc-9560-2376f89cc65e');
      expect(dto.slug, 'banghwasuryujeong');
      expect(dto.officialName, '방화수류정');
      expect(dto.displayName, '방화수류정(동북각루)');
      expect(dto.lat, 37.2870);
      expect(dto.lng, 127.0175);
      expect(dto.distanceM, 128.4);
      expect(dto.category, 'heritage-night-view');
      expect(dto.nightHighlight, '수면 반사와 정자 조명이 함께 보이는 구간');
      expect(dto.heroImageUrl, 'https://example.com/hero.jpg');
      expect(dto.crowdLevel, '여유');
      expect(dto.recommendationScore, 92.5);
      expect(dto.nightSuitabilityScore, 95.0);
      expect(dto.forecastStatus, 'forecast_available');
    });

    test('display_name/crowd_level이 없으면 official_name·null로 대체한다', () {
      final dto = NearbyPlaceDto.fromJson({
        'id': 'id-1',
        'slug': 'seojangdae',
        'official_name': '서장대',
        'lat': 37.2865,
        'lng': 127.0101,
        'distance_m': 900,
        'forecast_status': 'forecast_unavailable',
      });

      expect(dto.displayName, '서장대');
      expect(dto.nightHighlight, isNull);
      expect(dto.heroImageUrl, isNull);
      expect(dto.category, isNull);
      expect(dto.crowdLevel, isNull);
      expect(dto.recommendationScore, isNull);
      expect(dto.forecastStatus, 'forecast_unavailable');
    });
  });
}
