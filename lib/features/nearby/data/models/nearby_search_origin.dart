/// '내 주변' 검색 기준 좌표.
///
/// 사용자가 위치 권한을 허용했는지 여부에 따라 실제 좌표 또는 fallback 좌표
/// (수원화성 방화수류정 대표 좌표)로 결정된다. UI는 [isFallback]으로 안내
/// 배너 노출 여부를 판단한다.
///
/// 반경/정렬/혼잡도 같은 사용자 선택 필터는 [NearbyFilters]가 담당한다.
class NearbySearchOrigin {
  const NearbySearchOrigin({
    required this.lat,
    required this.lng,
    required this.isFallback,
  });

  /// 위치 권한이 없거나 GPS가 꺼진 경우 사용하는 fallback 좌표.
  /// 방화수류정과 화홍문 사이 지점(성곽 안쪽)이라 3km 반경으로 수원화성 대부분을 커버한다.
  static const fallback = NearbySearchOrigin(
    lat: 37.28617,
    lng: 127.01203,
    isFallback: true,
  );

  final double lat;
  final double lng;

  /// true면 사용자 실제 위치가 아니라 대표 좌표를 쓴 상태.
  final bool isFallback;
}
