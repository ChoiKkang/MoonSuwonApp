import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/nearby/data/models/nearby_filters.dart'
    show NearbyFilters;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show nearbyFiltersControllerProvider;

void main() {
  test('초기 상태는 반경 3km / 거리 정렬 / 혼잡도 필터 없음 이다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final filters = container.read(nearbyFiltersControllerProvider);

    expect(filters.radiusM, 3000);
    expect(filters.sortBy, NearbySortBy.distance);
    expect(filters.crowdLevels, isEmpty);
    expect(filters.isDefault, isTrue);
  });

  test('setRadius / setSortBy / toggleCrowdLevel 이 각각 상태를 갱신한다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(
      nearbyFiltersControllerProvider.notifier,
    );

    controller.setRadius(500);
    controller.setSortBy(NearbySortBy.recommendation);
    controller.toggleCrowdLevel('여유');
    controller.toggleCrowdLevel('보통');

    final state = container.read(nearbyFiltersControllerProvider);
    expect(state.radiusM, 500);
    expect(state.sortBy, NearbySortBy.recommendation);
    expect(state.crowdLevels, {'여유', '보통'});
    expect(state.isDefault, isFalse);
  });

  test('같은 값을 toggle 하면 제거된다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(
      nearbyFiltersControllerProvider.notifier,
    );

    controller.toggleCrowdLevel('여유');
    controller.toggleCrowdLevel('여유');

    expect(
      container.read(nearbyFiltersControllerProvider).crowdLevels,
      isEmpty,
    );
  });

  test('reset은 모든 필드를 기본값으로 되돌린다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(
      nearbyFiltersControllerProvider.notifier,
    );
    controller.setRadius(500);
    controller.setSortBy(NearbySortBy.nightSuitability);
    controller.toggleCrowdLevel('혼잡');
    expect(container.read(nearbyFiltersControllerProvider).isDefault, isFalse);

    controller.reset();
    expect(
      container.read(nearbyFiltersControllerProvider),
      const NearbyFilters(),
    );
    expect(container.read(nearbyFiltersControllerProvider).isDefault, isTrue);
  });
}
