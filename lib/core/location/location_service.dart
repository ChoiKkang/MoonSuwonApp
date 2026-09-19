import 'package:geolocator/geolocator.dart'
    show
        Geolocator,
        LocationAccuracy,
        LocationPermission,
        LocationSettings,
        Position;

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
  ///
  /// `Geolocator.getCurrentPosition()`은 기본적으로 시간 제한이 없어, 권한은
  /// 허용됐지만 위치 fix를 받지 못하는 상황(에뮬레이터/시뮬레이터, 콜드 GPS,
  /// 실내 등)에서 무한 대기할 수 있다. 이 경우 상위 화면이 fallback(예: 수원화성
  /// 기준)으로 넘어가지 못하고 무한 로딩에 걸린다. 이를 막기 위해:
  ///   1) 마지막으로 알려진 위치가 있으면 즉시 사용해 빠르게 표시하고,
  ///   2) 없으면 제한 시간(8초) 안에서 새 fix를 시도한다.
  /// 타임아웃/오류 시 `null`을 반환해 상위에서 fallback 좌표로 진행하게 한다.
  Future<Position?> getCurrentPositionAsync() async {
    final status = await ensurePermissionAsync();
    if (status != LocationAccessStatus.granted) {
      return null;
    }

    try {
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        return lastKnown;
      }
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          // 콜드 GPS에서 오래 붙잡히지 않도록 짧게 제한. 초과 시 TimeoutException
          // → null → 상위에서 수원화성 fallback으로 빠르게 진행(데이터 즉시 표시).
          timeLimit: Duration(seconds: 4),
        ),
      );
    } catch (_) {
      // 타임아웃(TimeoutException)/센서 오류 등은 위치 없음으로 취급해
      // 상위에서 fallback 좌표로 진행한다.
      return null;
    }
  }

  /// 앱 설정 화면(iOS Settings/Android App info)을 연다. 영구 거부(`deniedForever`)일 때 사용.
  Future<bool> openAppSettingsAsync() => Geolocator.openAppSettings();

  /// 시스템 위치 서비스 설정 화면을 연다. `serviceDisabled`일 때 사용.
  Future<bool> openLocationSettingsAsync() => Geolocator.openLocationSettings();
}
