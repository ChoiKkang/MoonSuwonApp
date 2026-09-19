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
        final summaries = await SpotRepositorySupabase(
          client,
        ).fetchNowGoodSpotsAsync();

        expect(requestPath, ['/rest/v1/rpc/get_now_good_spots']);
        expect(requestBodies, [
          {'p_lat': null, 'p_lng': null, 'p_limit': 20},
        ]);
        expect(summaries, hasLength(1));
        final summary = summaries.single;
        expect(summary, isA<SpotSummary>());
        expect(summary.slug, 'banghwasuryujeong');
        expect(summary.crowdLevel, '여유');
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test(
    'maps spot detail from the RPC and supplements accessibility/audio from views',
    () async {
      // Given a loopback endpoint that behaves like PostgREST for three sources:
      //   - rpc/get_place_by_slug (core fields + pet)
      //   - v_published_places (access_* columns)
      //   - v_published_place_audio_stories (audio rows)
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPaths = <String>[];
      final placeJson = <String, dynamic>{
        'id': 'cebde3c8-ff30-4f16-aaf7-6edffe3ae43b',
        'slug': 'hwahongmun',
        'official_name': '화홍문',
        'address_full': '경기도 수원시 팔달구 수원천로 377',
        'lat': 37.2870233,
        'lng': 127.01722,
        'contact_phone': null,
        'short_description': '수원천을 가로지르는 7개의 수문.',
        'recommended_stay_min': 30,
        'category': 'heritage',
        'display_name': '화홍문',
        'mission_radius_m': 80,
        'night_highlight': '7개의 아치 아래로 흐르는 물과 조명',
        'photo_tip': '수문 정면 다리 위에서 담아보세요.',
        'mission_type': 'photo',
        'mission_prompt': '7개의 수문 아치를 한 프레임에 담아보세요.',
        'couple_question': null,
        'short_story': null,
        'og_title': '화홍문',
        'og_description': null,
        'og_image_url': null,
        'images': [
          {
            'id': 'hero',
            'image_url': 'https://example.com/hwahongmun.jpg',
            'is_hero': true,
            'display_order': 0,
          },
        ],
        'pet_policy': 'unknown',
        'pet_note': null,
      };
      final accessObject = <String, dynamic>{
        'access_parking': '장애인 주차 구역 있음',
        'access_restroom': '장애인 전용 화장실 있음',
        'access_source_updated_at': '2026-04-01',
      };
      final audioRows = <Map<String, dynamic>>[
        {
          'story_lang_id': 'odii-hwahongmun-01',
          'spot_title': '화홍문',
          'audio_title': '황홀하다 화홍문(북수문)',
          'script': '과거 북수문 일대에는 큰 하천이 흐르고 있어서...',
          'play_seconds': null,
          'audio_url': null,
          'distance_m': 68,
        },
        {
          'story_lang_id': 'odii-banghwa-01',
          'spot_title': '방화수류정',
          'audio_title': '꽃을 찾는 방화수류정(동북각루)',
          'script': '화홍문 옆의 언덕에 위치한 동북각루...',
          'play_seconds': null,
          'audio_url': null,
          'distance_m': 90,
        },
      ];
      final subscription = server.listen((request) async {
        final path = request.uri.path;
        requestPaths.add(path);
        if (request.method == 'POST') {
          await utf8.decoder.bind(request).join();
        }
        dynamic data;
        if (path == '/rest/v1/rpc/get_place_by_slug') {
          data = placeJson;
        } else if (path == '/rest/v1/v_published_places') {
          data = accessObject; // maybeSingle → bare object
        } else if (path == '/rest/v1/v_published_place_audio_stories') {
          data = audioRows;
        } else {
          data = <dynamic>[];
        }
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(data));
        await request.response.close();
      });
      final client = SupabaseClient(
        'http://${server.address.host}:${server.port}',
        'test-publishable-key',
      );

      try {
        final detail = await SpotRepositorySupabase(
          client,
        ).fetchSpotDetailAsync('hwahongmun');

        // Core fields come from the RPC.
        expect(detail, isA<SpotDetail>());
        expect(detail.name, '화홍문');
        expect(detail.heroImageUrl, 'https://example.com/hwahongmun.jpg');
        expect(detail.missionRadiusM, 80);
        expect(detail.petPolicy, 'unknown');

        // Accessibility comes from v_published_places.
        expect(detail.accessibility.hasInfo, isTrue);
        final groupTitles = detail.accessibility.groups.map((g) => g.title);
        expect(groupTitles, containsAll(<String>['이동과 주차', '현장 편의']));
        expect(detail.accessibility.parking, '장애인 주차 구역 있음');

        // Audio comes from v_published_place_audio_stories, nearest first.
        expect(detail.audioStories, hasLength(2));
        expect(detail.audioStories.first.audioTitle, '황홀하다 화홍문(북수문)');
        expect(detail.audioStories.first.isReadable, isTrue);
        expect(detail.audioStories.first.distanceM, 68);

        // All three sources were queried.
        expect(
          requestPaths,
          containsAll(<String>[
            '/rest/v1/rpc/get_place_by_slug',
            '/rest/v1/v_published_places',
            '/rest/v1/v_published_place_audio_stories',
          ]),
        );
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );
}
