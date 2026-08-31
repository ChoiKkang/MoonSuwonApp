import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/location/location_service.dart'
    show LocationAccessStatus, LocationService;

/// 앱 전역 `LocationService` 싱글턴 Provider.
final locationServiceProvider = Provider<LocationService>(
  (ref) => const LocationService(),
);

/// 앱 진입 시 최초 위치 권한 요청 결과.
///
/// UI가 이 provider를 watch/read 하는 시점에 시스템 권한 요청 다이얼로그가 뜬다.
final locationPermissionProvider = FutureProvider<LocationAccessStatus>((ref) {
  return ref.read(locationServiceProvider).ensurePermissionAsync();
});
