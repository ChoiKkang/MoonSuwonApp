import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail;
import 'package:dalbit_suwon/features/spot/data/spot_repository_supabase.dart'
    show SpotRepositorySupabase;

void main() {
  test(
    'fetches now-good spots through the RPC and maps the summaries',
    () async {
      // Given a real loopback HTTP endpoint that behaves like PostgREST.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPath = <String>[];
      final requestBodies = <Map<String, dynamic>>[];
      final responseRows = <Map<String, dynamic>>[
        {
          'place_id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
          'slug': 'banghwasuryujeong',
          'display_name': '방화수류정(동북각루)',
          'hero_image_url': 'https://example.com/hero.jpg',
          'crowd_level': '여유',
          'distance_m': 321.4,
          'reason_label': '지금 비교적 여유로워요',
          'recommendation_score': 82.35,
          'forecast_status': 'forecast_available',
        },
      ];
      final subscription = server.listen((request) async {
        requestPath.add(request.uri.path);
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
        // When the repository performs its initial now-good query.
        final summaries = await SpotRepositorySupabase(
          client,
        ).fetchNowGoodSpotsAsync();

        // Then the real HTTP request and mapped output satisfy the contract.
        expect(requestPath, ['/rest/v1/rpc/get_now_good_spots']);
        expect(requestBodies, [
          {'p_lat': null, 'p_lng': null, 'p_limit': 20},
        ]);
        expect(summaries, hasLength(1));
        final summary = summaries.single;
        expect(summary, isA<SpotSummary>());
        expect(summary.id, 'c2dd085a-dff6-40fc-9560-2376f89cc65e');
        expect(summary.slug, 'banghwasuryujeong');
        expect(summary.name, '방화수류정(동북각루)');
        expect(summary.heroImageUrl, 'https://example.com/hero.jpg');
        expect(summary.crowdLevel, '여유');
        expect(summary.distanceM, 321.4);
        expect(summary.reasonLabel, '지금 비교적 여유로워요');
        expect(summary.recommendationScore, 82.35);
        expect(summary.forecastStatus, 'forecast_available');
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test(
    'fetches a live spot detail by slug through the get_place_by_slug RPC',
    () async {
      // Given a complete get_place_by_slug response from a real loopback endpoint.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPath = <String>[];
      final requestBodies = <Map<String, dynamic>>[];
      final response = <String, dynamic>{
        'id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
        'slug': 'seojangdae',
        'official_name': '서장대',
        'address_full': '경기도 수원시 팔달구 서장대동',
        'lat': 37.2865,
        'lng': 127.0101,
        'contact_phone': null,
        'short_description': null,
        'recommended_stay_min': 45,
        'category': 'heritage',
        'display_name': '효원의 종·서장대',
        'mission_radius_m': 80,
        'night_highlight': null,
        'photo_tip': null,
        'mission_type': 'photo',
        'mission_prompt': '서장대의 야경을 사진으로 남겨보세요.',
        'couple_question': null,
        'short_story': null,
        'og_title': '효원의 종·서장대',
        'og_description': null,
        'og_image_url': null,
        'images': [
          {
            'id': 'image-before-hero',
            'image_url': 'http://example.com/first.jpg',
            'is_hero': false,
            'display_order': 0,
          },
          {
            'id': 'image-hero',
            'image_url': 'https://example.com/seojangdae-hero.jpg',
            'is_hero': true,
            'display_order': 1,
          },
        ],
      };
      final subscription = server.listen((request) async {
        requestPath.add(request.uri.path);
        requestBodies.add(
          jsonDecode(await utf8.decoder.bind(request).join())
              as Map<String, dynamic>,
        );
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(response));
        await request.response.close();
      });
      final client = SupabaseClient(
        'http://${server.address.host}:${server.port}',
        'test-publishable-key',
      );

      try {
        // When the repository requests the live slug.
        final detail = await SpotRepositorySupabase(
          client,
        ).fetchSpotDetailAsync('seojangdae');

        // Then the RPC boundary and typed detail mapping preserve live data.
        expect(requestPath, ['/rest/v1/rpc/get_place_by_slug']);
        expect(requestBodies, [
          {'p_slug': 'seojangdae'},
        ]);
        expect(detail, isA<SpotDetail>());
        expect(detail.name, '효원의 종·서장대');
        expect(detail.heroImageUrl, 'https://example.com/seojangdae-hero.jpg');
        expect(detail.lat, 37.2865);
        expect(detail.lng, 127.0101);
        expect(detail.missionRadiusM, 80);
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test(
    'maps pet policy and accessibility facts when the RPC provides them',
    () async {
      // Given a get_place_by_slug response extended with pet_* / access_* fields
      // (the forward-compatible contract the web view already exposes).
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final response = <String, dynamic>{
        'id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
        'slug': 'hwaseong-haenggung',
        'official_name': '화성행궁',
        'address_full': '경기도 수원시 팔달구',
        'lat': 37.2836,
        'lng': 127.0093,
        'contact_phone': null,
        'short_description': '조선 최대 규모의 행궁',
        'recommended_stay_min': 60,
        'category': 'heritage',
        'display_name': '화성행궁',
        'mission_radius_m': 100,
        'night_highlight': null,
        'photo_tip': null,
        'mission_type': 'photo',
        'mission_prompt': '신풍루 앞에서 인증샷을 남겨보세요.',
        'couple_question': null,
        'short_story': null,
        'og_title': '화성행궁',
        'og_description': null,
        'og_image_url': null,
        'images': [
          {
            'id': 'hero',
            'image_url': 'https://example.com/haenggung.jpg',
            'is_hero': true,
            'display_order': 0,
          },
        ],
        // 전방 호환 필드.
        'pet_policy': 'allowed',
        'pet_note_short': '외부 광장은 리드줄 착용 시 동반 가능',
        'access_parking': '장애인 전용 주차구역이 있습니다.',
        'access_help_dog': '안내견 동반이 가능합니다.',
        'access_source_updated_at': '2026-06-05',
      };
      final subscription = server.listen((request) async {
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(response));
        await request.response.close();
      });
      final client = SupabaseClient(
        'http://${server.address.host}:${server.port}',
        'test-publishable-key',
      );

      try {
        final detail = await SpotRepositorySupabase(
          client,
        ).fetchSpotDetailAsync('hwaseong-haenggung');

        expect(detail.petPolicy, 'allowed');
        expect(detail.petNote, '외부 광장은 리드줄 착용 시 동반 가능');
        expect(detail.accessibility.hasInfo, isTrue);
        expect(detail.accessibility.groups.map((g) => g.title), [
          '이동과 주차',
          '안내와 보조',
        ]);
        expect(detail.accessibility.sourceUpdatedAt, '2026-06-05');
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );
}
