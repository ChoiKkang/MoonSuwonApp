/// `public.list_favorite_courses()` RPC 응답 행을 파싱하는 read-only DTO.
class FavoriteCourseDto {
  const FavoriteCourseDto({
    required this.courseId,
    required this.courseSlug,
    required this.heroTitle,
    required this.subtitle,
    required this.routeSummary,
    required this.estimatedDurationMin,
    required this.walkingDistanceKm,
    required this.recommendedStartTime,
    required this.spotCount,
    required this.heroImageUrl,
    required this.themeTags,
    required this.favoritedAt,
  });

  final String courseId;
  final String courseSlug;
  final String heroTitle;
  final String? subtitle;
  final String? routeSummary;
  final int estimatedDurationMin;
  final num walkingDistanceKm;
  final String? recommendedStartTime;
  final int spotCount;
  final String heroImageUrl;
  final List<String> themeTags;
  final DateTime favoritedAt;

  factory FavoriteCourseDto.fromJson(Map<String, dynamic> json) {
    return FavoriteCourseDto(
      courseId: json['course_id'] as String,
      courseSlug: json['course_slug'] as String,
      heroTitle: (json['hero_title'] as String?) ?? '',
      subtitle: json['subtitle'] as String?,
      routeSummary: json['route_summary'] as String?,
      estimatedDurationMin:
          (json['estimated_duration_min'] as num?)?.toInt() ?? 0,
      walkingDistanceKm: (json['walking_distance_km'] as num?) ?? 0,
      recommendedStartTime: json['recommended_start_time'] as String?,
      spotCount: (json['spot_count'] as num?)?.toInt() ?? 0,
      heroImageUrl: (json['hero_image_url'] as String?) ?? '',
      themeTags: ((json['theme_tags'] as List<dynamic>?) ?? const [])
          .map((e) => e as String)
          .toList(growable: false),
      favoritedAt: DateTime.parse(json['favorited_at'] as String),
    );
  }
}
