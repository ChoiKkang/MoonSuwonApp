import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/app_version/app_version_service.dart'
    show AppVersionInfo, AppVersionService;

/// 앱 전역 `AppVersionService` 싱글턴.
final appVersionServiceProvider = Provider<AppVersionService>(
  (ref) => AppVersionService(),
);

/// 앱 현재 버전 + 최신 버전 조회 결과.
///
/// 마이페이지 `버전 정보` 항목이 이 provider를 watch해서
/// 현재 버전을 표시하고, `hasUpgrade`가 true이면 클릭 시 앱스토어로 이동한다.
final appVersionInfoProvider = FutureProvider<AppVersionInfo>((ref) {
  return ref.read(appVersionServiceProvider).fetchAsync();
});
