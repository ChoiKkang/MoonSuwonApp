import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/course/data/course_repository_supabase.dart'
    show CourseRepositorySupabase;

void main() {
  test('get_home_courses RPC로 실제 코스 목록을 조회한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final responseRows = <Map<String, dynamic>>[
      {
        'id': '11111111-1111-1111-1111-111111111111',
        'slug': 'course-date-01',
        'theme_tags': ['date', 'night', 'beginner'],
        'estimated_duration_min': 90,
        'walking_distance_km': 2.1,
        'recommended_start_time': '18:30',
        'pet_ready_flag': false,
        'hero_title': '처음 가는 수원화성\n데이트 코스',
        'subtitle': '첫 방문자를 위한 야경 입문 코스',
        'route_summary': '팔달문 → 화성행궁 → 장안문 → 방화수류정',
        'spot_count': 4,
        'hero_image_url': 'https://example.com/date.jpg',
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
      final courses = await CourseRepositorySupabase(
        client,
      ).fetchCoursesAsync();

      expect(requestPaths, ['/rest/v1/rpc/get_home_courses']);
      expect(requestBodies, [
        {'p_limit': 10},
      ]);
      expect(courses, hasLength(1));
      final course = courses.single;
      expect(course.id, '11111111-1111-1111-1111-111111111111');
      expect(course.title, '처음 가는 수원화성\n데이트 코스');
      expect(course.spotCount, 4);
      expect(course.walkingDistanceKm, 2.1);
      expect(course.heroImageUrl, 'https://example.com/date.jpg');
      expect(course.themeTags, ['date', 'night', 'beginner']);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('get_course_detail RPC로 실제 코스 상세와 장소 순서를 조회한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final response = <String, dynamic>{
      'id': '11111111-1111-1111-1111-111111111111',
      'slug': 'course-date-01',
      'theme_tags': ['date', 'night', 'beginner'],
      'estimated_duration_min': 90,
      'walking_distance_km': 2.1,
      'recommended_start_time': '18:30',
      'pet_ready_flag': false,
      'hero_title': '처음 가는 수원화성\n데이트 코스',
      'subtitle': '첫 방문자를 위한 야경 입문 코스',
      'route_summary': '팔달문 → 화성행궁 → 장안문 → 방화수류정',
      'places': [
        {
          'order_index': 2,
          'place_id': '33333333-3333-3333-3333-333333333333',
          'slug': 'hwaseong-haenggung',
          'official_name': '수원 화성행궁',
          'display_name': '화성행궁',
          'lat': 37.2810,
          'lng': 127.0135,
          'mission_radius_m': 100,
          'mission_prompt': '신풍루를 배경으로 사진을 찍어보세요.',
          'night_highlight': '행궁의 은은한 야간 조명',
          'photo_tip': null,
          'short_story': null,
          'hero_image_url': 'https://example.com/haenggung.jpg',
        },
        {
          'order_index': 1,
          'place_id': '22222222-2222-2222-2222-222222222222',
          'slug': 'paldalmun',
          'official_name': '수원 팔달문',
          'display_name': '팔달문',
          'lat': 37.2782,
          'lng': 127.0169,
          'mission_radius_m': 100,
          'mission_prompt': '성문의 조명을 담아보세요.',
          'night_highlight': null,
          'photo_tip': '로터리 건너편에서 촬영하세요.',
          'short_story': null,
          'hero_image_url': 'https://example.com/paldalmun.jpg',
        },
      ],
    };
    final subscription = server.listen((request) async {
      requestPaths.add(request.uri.path);
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
      final detail = await CourseRepositorySupabase(
        client,
      ).fetchCourseDetailAsync('11111111-1111-1111-1111-111111111111');

      expect(requestPaths, ['/rest/v1/rpc/get_course_detail']);
      expect(requestBodies, [
        {'p_course_id': '11111111-1111-1111-1111-111111111111'},
      ]);
      expect(detail.id, '11111111-1111-1111-1111-111111111111');
      expect(detail.description, '팔달문 → 화성행궁 → 장안문 → 방화수류정');
      expect(detail.heroImageUrl, 'https://example.com/paldalmun.jpg');
      expect(detail.spots.map((spot) => spot.name), ['팔달문', '화성행궁']);
      expect(detail.spots.first.summary, '로터리 건너편에서 촬영하세요.');
      expect(detail.spots.last.summary, '행궁의 은은한 야간 조명');
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });
}
