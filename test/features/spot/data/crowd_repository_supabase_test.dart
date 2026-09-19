import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/spot/data/crowd_repository_supabase.dart'
    show CrowdForecastRepositorySupabase;

void main() {
  test('get_place_crowd_forecast RPC로 날짜별 예측을 매핑한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requestPath = <String>[];
    final requestBodies = <Map<String, dynamic>>[];
    final rows = <Map<String, dynamic>>[
      {
        'forecast_date': '2026-09-19',
        'forecast_score': 55.0,
        'crowd_level': '보통',
        'data_status': 'fresh',
      },
      {
        'forecast_date': '2026-09-20',
        'forecast_score': 28.0,
        'crowd_level': '여유',
        'data_status': 'fresh',
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
        ..write(jsonEncode(rows));
      await request.response.close();
    });
    final client = SupabaseClient(
      'http://${server.address.host}:${server.port}',
      'test-publishable-key',
    );

    try {
      final forecast = await CrowdForecastRepositorySupabase(
        client,
      ).fetchCrowdForecastAsync('place-uuid');

      expect(requestPath, ['/rest/v1/rpc/get_place_crowd_forecast']);
      expect(requestBodies, [
        {'p_place_id': 'place-uuid'},
      ]);
      expect(forecast.available, isTrue);
      expect(forecast.days.map((d) => d.date).toList(), [
        '2026-09-19',
        '2026-09-20',
      ]);
      expect(forecast.today?.level, '보통');
      expect(forecast.today?.score, 55.0);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });

  test('RPC가 없거나(404) 오류면 예외 없이 빈 예측을 반환한다', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final subscription = server.listen((request) async {
      request.response
        ..statusCode = HttpStatus.notFound
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'message': 'function not found'}));
      await request.response.close();
    });
    final client = SupabaseClient(
      'http://${server.address.host}:${server.port}',
      'test-publishable-key',
    );

    try {
      final forecast = await CrowdForecastRepositorySupabase(
        client,
      ).fetchCrowdForecastAsync('place-uuid');

      expect(forecast.available, isFalse);
      expect(forecast.days, isEmpty);
    } finally {
      await client.dispose();
      await subscription.cancel();
      await server.close(force: true);
    }
  });
}
