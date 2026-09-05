import 'package:dalbit_suwon/features/nearby/data/models/nearby_sort_by.dart'
    show NearbySortBy;

/// 사용자가 '내 주변'에서 선택한 필터/정렬 조합.
///
/// - [radiusM]: 500 / 1000 / 3000 / 5000 중 하나.
/// - [sortBy]: 거리 / 추천 / 야간 적합도.
/// - [crowdLevels]: '여유'/'보통'/'혼잡' 중 사용자가 허용한 값 집합.
///   비어 있으면 필터링 없이 모두 반환.
///
/// 기본값(생성자 무인자)은 필터가 하나도 적용되지 않은 상태와 같다.
class NearbyFilters {
  const NearbyFilters({
    this.radiusM = defaultRadiusM,
    this.sortBy = NearbySortBy.distance,
    this.crowdLevels = const <String>{},
  });

  /// MVP 기본 반경 (3km). 수원화성 성곽 반경 대부분 커버.
  static const defaultRadiusM = 3000;

  /// UI에서 노출되는 반경 옵션.
  static const radiusOptionsM = <int>[500, 1000, 3000, 5000];

  /// UI에서 노출되는 혼잡도 옵션.
  static const crowdLevelOptions = <String>['여유', '보통', '혼잡'];

  final int radiusM;
  final NearbySortBy sortBy;
  final Set<String> crowdLevels;

  /// 모든 필드가 기본값과 같은지. UI의 "초기화" 버튼 노출 조건.
  bool get isDefault =>
      radiusM == defaultRadiusM &&
      sortBy == NearbySortBy.distance &&
      crowdLevels.isEmpty;

  NearbyFilters copyWith({
    int? radiusM,
    NearbySortBy? sortBy,
    Set<String>? crowdLevels,
  }) {
    return NearbyFilters(
      radiusM: radiusM ?? this.radiusM,
      sortBy: sortBy ?? this.sortBy,
      crowdLevels: crowdLevels ?? this.crowdLevels,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NearbyFilters &&
        other.radiusM == radiusM &&
        other.sortBy == sortBy &&
        _setEquals(other.crowdLevels, crowdLevels);
  }

  @override
  int get hashCode => Object.hash(
    radiusM,
    sortBy,
    Object.hashAllUnordered(crowdLevels),
  );

  static bool _setEquals(Set<String> a, Set<String> b) {
    if (a.length != b.length) return false;
    for (final value in a) {
      if (!b.contains(value)) return false;
    }
    return true;
  }
}
