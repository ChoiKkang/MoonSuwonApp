import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' show Position;

import 'package:dalbit_suwon/core/location/location_provider.dart'
    show locationServiceProvider;
import 'package:dalbit_suwon/core/location/location_service.dart'
    show LocationService;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_search_origin.dart'
    show NearbySearchOrigin;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show nearbySearchOriginProvider;

/// 위치를 못 얻는(게스트/권한 거부/타임아웃) 상황을 흉내낸다.
class _NoLocationService extends LocationService {
  const _NoLocationService();
  @override
  Future<Position?> getCurrentPositionAsync() async => null;
}

void main() {
  test('위치를 못 얻으면 수원화성 fallback 좌표로 진행한다(무한 로딩 방지)', () async {
    final container = ProviderContainer(
      overrides: [
        locationServiceProvider.overrideWithValue(const _NoLocationService()),
      ],
    );
    addTearDown(container.dispose);

    final origin = await container.read(nearbySearchOriginProvider.future);

    expect(origin.isFallback, isTrue);
    expect(origin.lat, NearbySearchOrigin.fallback.lat);
    expect(origin.lng, NearbySearchOrigin.fallback.lng);
  });
}
