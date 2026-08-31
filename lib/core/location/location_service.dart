import 'package:geolocator/geolocator.dart'
    show Geolocator, LocationPermission, Position;

/// 위치 서비스 상태 + 권한 요청 결과를 하나의 값으로 표현한다.
enum LocationAccessStatus {
  /// 위치 권한이 허용됨 (whileInUse 또는 always).
  granted,

  /// 사용자가 이번에 거부한 상태. 재요청 가능.
  denied,

  /// 사용자가 영구 거부. 설정 앱에서 직접 변경해야 한다.
  deniedForever,

  /// 위치 서비스(GPS 등) 자체가 꺼져 있는 상태.
  serviceDisabled,
}

/// 위치 권한 확인/요청과 현재 위치 조회를 담당하는 유틸.
///
/// UI/Provider 계층에서 이 서비스만 호출하도록 하여 `geolocator` 의존을 이 파일 하나로 격리한다.
class LocationService {
  const LocationService();

  /// 위치 서비스 활성화 여부와 권한 상태를 확인하고, 필요 시 권한 요청을 띄운다.
  ///
  /// - 이미 허용된 상태면 다이얼로그를 띄우지 않는다.
  /// - `denied` 상태면 시스템 권한 요청 다이얼로그를 표시한다.
  Future<LocationAccessStatus> ensurePermissionAsync() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationAccessStatus.serviceDisabled;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return LocationAccessStatus.granted;
      case LocationPermission.deniedForever:
        return LocationAccessStatus.deniedForever;
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        return LocationAccessStatus.denied;
    }
  }

  /// 현재 위치를 조회한다. 권한이 없거나 위치 서비스가 꺼져 있으면 `null`.
  Future<Position?> getCurrentPositionAsync() async {
    final status = await ensurePermissionAsync();
    if (status != LocationAccessStatus.granted) {
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      // 타임아웃/센서 오류 등은 상위에서 위치 없음으로 취급한다.
      return null;
    }
  }
}
