import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/notification/notification_service.dart'
    show NotificationAccessStatus, NotificationService;

/// 앱 전역 `NotificationService` 싱글턴.
final notificationServiceProvider = Provider<NotificationService>(
  (ref) => const NotificationService(),
);

/// 현재 알림 권한 상태 (다이얼로그 없이 조회만).
final notificationPermissionProvider =
    FutureProvider<NotificationAccessStatus>((ref) {
  return ref.read(notificationServiceProvider).getStatusAsync();
});
