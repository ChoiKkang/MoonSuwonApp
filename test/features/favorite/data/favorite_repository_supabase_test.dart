import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository_supabase.dart'
    show FavoriteRepositorySupabase;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

void main() {
  test(
    'list_favorite_spots RPC 응답을 FavoriteSpotSummary 리스트로 매핑한다',
    () async {
      // Given a real loopback HTTP endpoint that returns list_favorite_spots rows.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPaths = <String>[];
      final responseRows = <Map<String, dynamic>>[
        {
          'place_id': 'b98a0000-0000-0000-0000-000000000001',
          'place_slug': 'banghwasuryujeong',
          'display_name': '방화수류정',
          'category': 'heritage-night-view',
          'hero_image_url': 'https://example.com/hero.jpg',
          'night_highlight': '연못에 비친 달빛',
          'favorited_at': '2026-08-31T12:00:00.000Z',
        },
      ];
      final subscription = server.listen((request) async {
        requestPaths.add(request.uri.path);
        await utf8.decoder.bind(request).join();
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
        final spots = await FavoriteRepositorySupabase(
          client,
        ).fetchFavoriteSpotsAsync();

        expect(requestPaths, ['/rest/v1/rpc/list_favorite_spots']);
        expect(spots, hasLength(1));
        final spot = spots.single;
        expect(spot, isA<FavoriteSpotSummary>());
        expect(spot.placeId, 'b98a0000-0000-0000-0000-000000000001');
        expect(spot.slug, 'banghwasuryujeong');
        expect(spot.name, '방화수류정');
        expect(spot.category, 'heritage-night-view');
        expect(spot.heroImageUrl, 'https://example.com/hero.jpg');
        expect(spot.nightHighlight, '연못에 비친 달빛');
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test(
    'list_favorite_courses RPC 응답을 FavoriteCourseSummary 리스트로 매핑한다',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestPaths = <String>[];
      final responseRows = <Map<String, dynamic>>[
        {
          'course_id': 'c98a0000-0000-0000-0000-000000000001',
          'course_slug': 'course-night-photo',
          'hero_title': '야경 사진 집중 코스',
          'subtitle': '첫 방문자를 위한 야경 코스',
          'route_summary': '장안문 → 화홍문 → 방화수류정',
          'estimated_duration_min': 90,
          'walking_distance_km': 2.0,
          'recommended_start_time': '19:00',
          'spot_count': 3,
          'hero_image_url': 'https://example.com/course-hero.jpg',
          'theme_tags': ['photo', 'night-view'],
          'favorited_at': '2026-08-31T12:00:00.000Z',
        },
      ];
      final subscription = server.listen((request) async {
        requestPaths.add(request.uri.path);
        await utf8.decoder.bind(request).join();
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
        final courses = await FavoriteRepositorySupabase(
          client,
        ).fetchFavoriteCoursesAsync();

        expect(requestPaths, ['/rest/v1/rpc/list_favorite_courses']);
        expect(courses, hasLength(1));
        final course = courses.single;
        expect(course, isA<FavoriteCourseSummary>());
        expect(course.courseId, 'c98a0000-0000-0000-0000-000000000001');
        expect(course.slug, 'course-night-photo');
        expect(course.title, '야경 사진 집중 코스');
        expect(course.estimatedDurationMin, 90);
        expect(course.spotCount, 3);
        expect(course.themeTags, ['photo', 'night-view']);
      } finally {
        await client.dispose();
        await subscription.cancel();
        await server.close(force: true);
      }
    },
  );

  test('addSpotAsync는 upsert_favorite RPC를 spot 파라미터로 호출한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final subscription = server.listen((request) async {
      requestPaths.add(request.uri.path);
      requestBodies.add(
        jsonDecode(await utf8.decoder.bind(request).join())
            as Map<String, dynamic>,
      );
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write('null');
      await request.response.close();
    });
    final client = SupabaseClient(
      'http://${server.address.host}:${server.port}',
      'test-publishable-key',
    );

    try {
      await FavoriteRepositorySupabase(client).addSpotAsync(
        const FavoriteSpotSummary(
          placeId: 'b98a0000-0000-0000-0000-000000000001',
          slug: 'banghwasuryujeong',
          name: '방화수류정',
          category: 'heritage-night-view',
          heroImageUrl: 'https://example.com/hero.jpg',
        ),
      );

      expect(requestPaths, ['/rest/v1/rpc/upsert_favorite']);
      expect(requestBodies, [
        {
          'p_target_type': 'spot',
          'p_target_id': 'b98a0000-0000-0000-0000-000000000001',
        },
      ]);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('removeAsync는 remove_favorite RPC를 대상 타입/id로 호출한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final subscription = server.listen((request) async {
      requestPaths.add(request.uri.path);
      requestBodies.add(
        jsonDecode(await utf8.decoder.bind(request).join())
            as Map<String, dynamic>,
      );
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write('null');
      await request.response.close();
    });
    final client = SupabaseClient(
      'http://${server.address.host}:${server.port}',
      'test-publishable-key',
    );

    try {
      await FavoriteRepositorySupabase(client).removeAsync(
        const FavoriteTarget(
          type: FavoriteTargetType.course,
          id: 'c98a0000-0000-0000-0000-000000000001',
        ),
      );

      expect(requestPaths, ['/rest/v1/rpc/remove_favorite']);
      expect(requestBodies, [
        {
          'p_target_type': 'course',
          'p_target_id': 'c98a0000-0000-0000-0000-000000000001',
        },
      ]);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });
}
