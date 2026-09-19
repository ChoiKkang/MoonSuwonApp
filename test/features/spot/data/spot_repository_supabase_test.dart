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
        expect(summaries.single, isA<SpotSummary>());
        expect(summaries.single.slug, 'banghwasuryujeong');
        expect(summaries.single.crowdLevel, '여유');
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test(
    'maps spot detail (core + pet + accessibility + audio) from a single RPC',
    () async {
      // get_place_by_slug 확장(20260919280000) 이후: 코어·pet·access_*·audio_stories를
      // RPC 한 번으로 반환한다. 앱은 뷰 폴백 없이 단일 RPC 결과만으로 상세를 구성한다.
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
        'pet_policy': 'unknown',
        'pet_note': null,
        'access_parking': '장애인 주차 구역 있음',
        'access_restroom': '장애인 전용 화장실 있음',
        'access_source_updated_at': '2026-04-01',
        'images': [
          {
            'id': 'hero',
            'image_url': 'https://example.com/hwahongmun.jpg',
            'is_hero': true,
            'display_order': 0,
          },
        ],
        'audio_stories': [
          {
            'story_lang_id': 'odii-hwahongmun-01',
            'spot_title': '화홍문',
            'audio_title': '황홀하다 화홍문(북수문)',
            'script': '과거 북수문 일대에는...',
            'play_seconds': null,
            'audio_url': null,
            'distance_m': 68,
          },
        ],
      };
      final subscription = server.listen((request) async {
        requestPaths.add(request.uri.path);
        if (request.method == 'POST') {
          await utf8.decoder.bind(request).join();
        }
        request.response
          ..statusCode = HttpStatus.ok
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(placeJson));
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

        // 코어 필드.
        expect(detail, isA<SpotDetail>());
        expect(detail.name, '화홍문');
        expect(detail.heroImageUrl, 'https://example.com/hwahongmun.jpg');
        expect(detail.missionRadiusM, 80);
        expect(detail.petPolicy, 'unknown');

        // 접근성(access_*).
        expect(detail.accessibility.hasInfo, isTrue);
        expect(detail.accessibility.parking, '장애인 주차 구역 있음');
        expect(
          detail.accessibility.groups.map((g) => g.title),
          containsAll(<String>['이동과 주차', '현장 편의']),
        );

        // 오디오 해설(audio_stories).
        expect(detail.audioStories, hasLength(1));
        expect(detail.audioStories.first.audioTitle, '황홀하다 화홍문(북수문)');
        expect(detail.audioStories.first.isReadable, isTrue);
        expect(detail.audioStories.first.distanceM, 68);

        // 단일 RPC만 호출한다(뷰 폴백 없음).
        expect(requestPaths, ['/rest/v1/rpc/get_place_by_slug']);
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );
}
