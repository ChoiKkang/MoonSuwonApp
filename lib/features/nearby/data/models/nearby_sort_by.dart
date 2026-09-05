/// '내 주변' 리스트 정렬 방식.
///
/// 서버 RPC `public.get_nearby_places(..., p_sort_by text, ...)`가 받는
/// 문자열 값과 UI 라벨을 한 곳에서 관리한다.
enum NearbySortBy {
  distance('distance', '가까운 순'),
  recommendation('recommendation', '추천 순'),
  nightSuitability('night_suitability', '야간 명소 순');

  const NearbySortBy(this.wire, this.label);

  /// RPC 파라미터로 전달되는 문자열.
  final String wire;

  /// UI에 노출되는 한글 라벨.
  final String label;
}
