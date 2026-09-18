import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/models/now_good_spot_dto.dart'
    show NowGoodSpotDto;

void main() {
  test('maps every now-good RPC column into a typed DTO', () {
    // Given the complete row returned by get_now_good_spots.
    final row = <String, dynamic>{
      'place_id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
      'slug': 'banghwasuryujeong',
      'display_name': '방화수류정(동북각루)',
      'hero_image_url': 'https://example.com/hero.jpg',
      'crowd_level': '여유',
      'distance_m': 321.4,
      'reason_label': '지금 비교적 여유로워요',
      'recommendation_score': 82.35,
      'forecast_status': 'forecast_available',
    };

    // When the RPC row crosses the DTO boundary.
    final dto = NowGoodSpotDto.fromJson(row);

    // Then every response value is preserved with its domain type.
    expect(dto.placeId, 'c2dd085a-dff6-40fc-9560-2376f89cc65e');
    expect(dto.slug, 'banghwasuryujeong');
    expect(dto.displayName, '방화수류정(동북각루)');
    expect(dto.heroImageUrl, 'https://example.com/hero.jpg');
    expect(dto.crowdLevel, '여유');
    expect(dto.distanceM, 321.4);
    expect(dto.reasonLabel, '지금 비교적 여유로워요');
    expect(dto.recommendationScore, 82.35);
    expect(dto.forecastStatus, 'forecast_available');
  });
}
