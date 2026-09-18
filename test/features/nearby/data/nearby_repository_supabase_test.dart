import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/data/nearby_repository_supabase.dart'
    show NearbyRepositorySupabase;

void main() {
  test(
    'get_nearby_places RPC로 인근 스팟을 조회하고 필터/정렬을 페이로드에 반영한다',
    () async {
      // Given a real loopback HTTP endpoint that behaves like PostgREST.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPaths = <String>[];
      final requestBodies = <Map<String, dynamic>>[];
      final responseRows = <Map<String, dynamic>>[
        {
          'id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
          'slug': 'banghwasuryujeong',
          'official_name': '방화수류정',
          'lat': 37.2870,
          'lng': 127.0175,
          'category': 'heritage-night-view',
          'display_name': '방화수류정(동북각루)',
          'night_highlight': '수면 반사와 정자 조명이 함께 보이는 구간',
          'hero_image_url': 'https://example.com/hero-banghwa.jpg',
          'distance_m': 128.4,
          'crowd_level': '여유',
          'recommendation_score': 92.5,
          'night_suitability_score': 95.0,
          'forecast_status': 'forecast_available',
        },
        {
          'id': 'a3d5f01b-1111-2222-3333-4444abcd5678',
          'slug': 'yongyeon',
          'official_name': '용연',
          'lat': 37.2885,
          'lng': 127.0168,
          'category': 'heritage-night-view',
          'display_name': null,
          'night_highlight': null,
          'hero_image_url': null,
          'distance_m': 320.9,
          'crowd_level': null,
          'recommendation_score': 60.0,
          'night_suitability_score': 78.0,
          'forecast_status': 'forecast_unavailable',
        },
      ];
      final subscription = server.listen((request) async {
        requestPaths.add(request.uri.path);
        requestBodies.add(
          jsonDecode(await utf8.decoder.bind(request).join())
              as Map<String, dynamic>,
        );
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(responseRows));
        await request.response.close();
      });
      final client = SupabaseClient(
        'http://${server.address.host}:${server.port}',
        'test-publishable-key',
      );

      try {
        final results = await NearbyRepositorySupabase(client)
            .fetchNearbyPlacesAsync(
              lat: 37.28617,
              lng: 127.01203,
              radiusM: 1000,
              sortBy: NearbySortBy.recommendation,
              crowdLevels: {'여유', '보통'},
            );

        expect(requestPaths, ['/rest/v1/rpc/get_nearby_places']);
        expect(requestBodies, hasLength(1));
        final body = requestBodies.single;
        expect(body['p_lat'], 37.28617);
        expect(body['p_lng'], 127.01203);
        expect(body['p_radius_m'], 1000);
        expect(body['p_sort_by'], 'recommendation');
        expect(
          (body['p_crowd_levels'] as List<dynamic>).toSet(),
          {'여유', '보통'},
        );

        expect(results, hasLength(2));

        final banghwa = results[0];
        expect(banghwa.crowdLevel, '여유');
        expect(banghwa.recommendationScore, 92.5);
        expect(banghwa.nightSuitabilityScore, 95.0);
        expect(banghwa.forecastStatus, 'forecast_available');
        expect(banghwa.hasForecast, isTrue);

        final yongyeon = results[1];
        expect(yongyeon.displayName, '용연'); // official_name fallback
        expect(yongyeon.crowdLevel, isNull);
        expect(yongyeon.forecastStatus, 'forecast_unavailable');
        expect(yongyeon.hasForecast, isFalse);
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );
}
