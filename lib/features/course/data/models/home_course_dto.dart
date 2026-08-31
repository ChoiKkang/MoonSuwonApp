class HomeCoursesQueryDto {
  const HomeCoursesQueryDto({this.limit = 10});

  final int limit;

  Map<String, dynamic> toJson() => {'p_limit': limit};
}

class HomeCourseDto {
  const HomeCourseDto({
    required this.id,
    required this.slug,
    required this.themeTags,
    required this.estimatedDurationMin,
    required this.walkingDistanceKm,
    required this.recommendedStartTime,
    required this.petReadyFlag,
    required this.heroTitle,
    required this.subtitle,
    required this.routeSummary,
    required this.spotCount,
    required this.heroImageUrl,
  });

  factory HomeCourseDto.fromJson(Map<String, dynamic> json) {
    return HomeCourseDto(
      id: json['id'] as String,
      slug: json['slug'] as String,
      themeTags: (json['theme_tags'] as List<dynamic>? ?? const [])
          .map((tag) => tag as String)
          .toList(),
      estimatedDurationMin: (json['estimated_duration_min'] as num).toInt(),
      walkingDistanceKm: (json['walking_distance_km'] as num?)?.toDouble() ?? 0,
      recommendedStartTime: json['recommended_start_time'] as String? ?? '',
      petReadyFlag: json['pet_ready_flag'] as bool? ?? false,
      heroTitle: json['hero_title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      routeSummary: json['route_summary'] as String?,
      spotCount: (json['spot_count'] as num).toInt(),
      heroImageUrl: json['hero_image_url'] as String? ?? '',
    );
  }

  final String id;
  final String slug;
  final List<String> themeTags;
  final int estimatedDurationMin;
  final double walkingDistanceKm;
  final String recommendedStartTime;
  final bool petReadyFlag;
  final String heroTitle;
  final String subtitle;
  final String? routeSummary;
  final int spotCount;
  final String heroImageUrl;
}
