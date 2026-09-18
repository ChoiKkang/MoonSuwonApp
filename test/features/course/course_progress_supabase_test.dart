import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/course/data/course_repository_supabase.dart'
    show CourseRepositorySupabase;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CheckinMode, CheckinResult;

/// 실제 Supabase RPC 계약을 대상으로 HttpServer 기반 통합 스타일 테스트.
///
/// - `start_course_progress` → `core.user_course_progress` INSERT 결과 반환
/// - `checkin_place` → 'success' | 'out_of_range' | 'already_checked'
/// - `complete_course_progress` → status/completed_at 갱신 결과 반환
/// - `list_user_course_history` → 사용자 기록 rowset
void main() {
  test('start_course_progress RPC로 진행 세션을 시작한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final response = <String, dynamic>{
      'progress_id': '99999999-9999-9999-9999-999999999999',
      'course_id': '11111111-1111-1111-1111-111111111111',
      'status': 'in_progress',
      'started_at': '2026-08-31T14:20:00.000Z',
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
      final session = await CourseRepositorySupabase(client)
          .startCourseProgressAsync('11111111-1111-1111-1111-111111111111');

      expect(requestPaths, ['/rest/v1/rpc/start_course_progress']);
      expect(requestBodies, [
        {'p_course_id': '11111111-1111-1111-1111-111111111111'},
      ]);
      expect(session.progressId, '99999999-9999-9999-9999-999999999999');
      expect(session.courseId, '11111111-1111-1111-1111-111111111111');
      expect(session.inProgress, true);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('checkin_place RPC로 현재 스팟을 체크인한다', () async {
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
        ..write(jsonEncode('success'));
      await request.response.close();
    });
    final client = SupabaseClient(
      'http://${server.address.host}:${server.port}',
      'test-publishable-key',
    );

    try {
      final result = await CourseRepositorySupabase(client)
          .checkinCoursePlaceAsync(
        progressId: '99999999-9999-9999-9999-999999999999',
        placeId: '22222222-2222-2222-2222-222222222222',
        mode: CheckinMode.manual,
        lat: 37.2872,
        lng: 127.0176,
      );

      expect(result, CheckinResult.success);
      expect(requestPaths, ['/rest/v1/rpc/checkin_place']);
      expect(requestBodies, [
        {
          'p_progress_id': '99999999-9999-9999-9999-999999999999',
          'p_place_id': '22222222-2222-2222-2222-222222222222',
          'p_lat': 37.2872,
          'p_lng': 127.0176,
          'p_mode': 'manual',
        },
      ]);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('complete_course_progress RPC로 코스 완료를 저장한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final response = <String, dynamic>{
      'progress_id': '99999999-9999-9999-9999-999999999999',
      'course_id': '11111111-1111-1111-1111-111111111111',
      'status': 'completed',
      'started_at': '2026-08-31T14:20:00.000Z',
      'completed_at': '2026-08-31T16:05:00.000Z',
      'checkin_count': 4,
      'spot_count': 4,
      'is_perfect': true,
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
      final session = await CourseRepositorySupabase(client)
          .completeCourseProgressAsync(
              '99999999-9999-9999-9999-999999999999');

      expect(requestPaths, ['/rest/v1/rpc/complete_course_progress']);
      expect(requestBodies, [
        {'p_progress_id': '99999999-9999-9999-9999-999999999999'},
      ]);
      expect(session.isCompleted, true);
      expect(session.checkinCount, 4);
      expect(session.spotCount, 4);
      expect(session.isPerfect, true);
      expect(session.completedAt, DateTime.utc(2026, 8, 31, 16, 5));
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('list_user_course_history RPC로 진행 기록을 조회한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPaths = <String>[];
    final response = <Map<String, dynamic>>[
      {
        'progress_id': '99999999-9999-9999-9999-999999999999',
        'course_id': '11111111-1111-1111-1111-111111111111',
        'course_slug': 'course-date-01',
        'hero_title': '처음 가는 수원화성 데이트 코스',
        'subtitle': '첫 방문자를 위한 야경 입문 코스',
        'route_summary': '팔달문 → 화성행궁 → 장안문 → 방화수류정',
        'hero_image_url': 'https://example.com/date.jpg',
        'status': 'completed',
        'started_at': '2026-08-31T14:20:00.000Z',
        'completed_at': '2026-08-31T16:05:00.000Z',
        'checkin_count': 4,
        'spot_count': 4,
        'walking_distance_km': 2.1,
        'estimated_duration_min': 90,
      },
    ];
    final subscription = server.listen((request) async {
      requestPaths.add(request.uri.path);
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
      final history = await CourseRepositorySupabase(client)
          .listUserCourseHistoryAsync();

      expect(requestPaths, ['/rest/v1/rpc/list_user_course_history']);
      expect(history, hasLength(1));
      final entry = history.single;
      expect(entry.courseSlug, 'course-date-01');
      expect(entry.status, 'completed');
      expect(entry.checkinCount, 4);
      expect(entry.spotCount, 4);
      expect(entry.walkingDistanceKm, 2.1);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });
}
