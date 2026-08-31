import 'package:permission_handler/permission_handler.dart';

/// 알림 권한 상태를 앱 도메인 언어로 표현.
enum NotificationAccessStatus {
  /// 사용자가 알림을 허용함 (푸시 수신 가능).
  granted,

  /// 아직 요청되지 않았거나 이번에 거부된 상태. 재요청 가능.
  denied,

  /// 사용자가 영구 거부하여 앱 설정에서 직접 변경해야 함.
  permanentlyDenied,

  /// 시스템 정책상 접근 제한(예: iOS Family 제한).
  restricted,
}

/// 푸시 알림 권한 확인 및 요청을 담당하는 유틸.
///
/// `permission_handler` 의존을 이 파일 하나로 격리한다.
class NotificationService {
  const NotificationService();

  /// 현재 알림 권한 상태를 조회한다 (사용자에게 다이얼로그를 띄우지 않음).
  Future<NotificationAccessStatus> getStatusAsync() async {
    final status = await Permission.notification.status;
    return _mapStatus(status);
  }

  /// 알림 권한을 요청한다. 이미 허용된 상태면 다이얼로그가 뜨지 않는다.
  Future<NotificationAccessStatus> requestAsync() async {
    final status = await Permission.notification.request();
    return _mapStatus(status);
  }

  /// permanentlyDenied 상태에서 사용자를 앱 설정 화면으로 이동시킨다.
  Future<bool> openAppSettingsAsync() {
    return openAppSettings();
  }

  NotificationAccessStatus _mapStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return NotificationAccessStatus.granted;
      case PermissionStatus.permanentlyDenied:
        return NotificationAccessStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        return NotificationAccessStatus.restricted;
      case PermissionStatus.denied:
        return NotificationAccessStatus.denied;
    }
  }
}
