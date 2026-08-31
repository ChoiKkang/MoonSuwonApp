/// 찜 목록/토글 UI에 표시할 스팟 요약 정보.
///
/// 원본 `SpotSummary`와 필드가 조금 다르다: 찜 카드는 거리/인기점수 대신
/// `nightHighlight` 문구를 부제로 보여주기 때문에 별도 값 오브젝트로 둔다.
class FavoriteSpotSummary {
  const FavoriteSpotSummary({
    required this.placeId,
    required this.slug,
    required this.name,
    required this.category,
    required this.heroImageUrl,
    this.nightHighlight,
  });

  final String placeId;
  final String slug;
  final String name;
  final String category;
  final String heroImageUrl;
  final String? nightHighlight;
}
