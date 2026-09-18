/// `public.list_favorite_spots()` RPC 응답 행을 파싱하는 read-only DTO.
class FavoriteSpotDto {
  const FavoriteSpotDto({
    required this.placeId,
    required this.placeSlug,
    required this.displayName,
    required this.category,
    required this.heroImageUrl,
    required this.nightHighlight,
    required this.favoritedAt,
  });

  final String placeId;
  final String placeSlug;
  final String displayName;
  final String category;
  final String heroImageUrl;
  final String? nightHighlight;
  final DateTime favoritedAt;

  factory FavoriteSpotDto.fromJson(Map<String, dynamic> json) {
    return FavoriteSpotDto(
      placeId: json['place_id'] as String,
      placeSlug: json['place_slug'] as String,
      displayName: json['display_name'] as String,
      category: (json['category'] as String?) ?? 'heritage-night-view',
      heroImageUrl: (json['hero_image_url'] as String?) ?? '',
      nightHighlight: json['night_highlight'] as String?,
      favoritedAt: DateTime.parse(json['favorited_at'] as String),
    );
  }
}
