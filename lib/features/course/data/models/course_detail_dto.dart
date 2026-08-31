class CourseDetailQueryDto {
  const CourseDetailQueryDto(this.courseId);

  final String courseId;

  Map<String, dynamic> toJson() => {'p_course_id': courseId};
}

class CoursePlaceDto {
  const CoursePlaceDto({
    required this.orderIndex,
    required this.placeId,
    required this.slug,
    required this.officialName,
    required this.displayName,
    required this.lat,
    required this.lng,
    required this.missionRadiusM,
    required this.missionPrompt,
    required this.nightHighlight,
    required this.photoTip,
    required this.shortStory,
    required this.heroImageUrl,
  });

  factory CoursePlaceDto.fromJson(Map<String, dynamic> json) {
    return CoursePlaceDto(
      orderIndex: (json['order_index'] as num).toInt(),
      placeId: json['place_id'] as String,
      slug: json['slug'] as String,
      officialName: json['official_name'] as String,
      displayName:
          json['display_name'] as String? ?? json['official_name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      missionRadiusM: (json['mission_radius_m'] as num?)?.toInt() ?? 80,
      missionPrompt: json['mission_prompt'] as String?,
      nightHighlight: json['night_highlight'] as String?,
      photoTip: json['photo_tip'] as String?,
      shortStory: json['short_story'] as String?,
      heroImageUrl: json['hero_image_url'] as String?,
    );
  }

  final int orderIndex;
  final String placeId;
  final String slug;
  final String officialName;
  final String displayName;
  final double lat;
  final double lng;
  final int missionRadiusM;
  final String? missionPrompt;
  final String? nightHighlight;
  final String? photoTip;
  final String? shortStory;
  final String? heroImageUrl;
}

class CourseDetailDto {
  const CourseDetailDto({
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
    required this.places,
  });

  factory CourseDetailDto.fromJson(Map<String, dynamic> json) {
    final placeRows = json['places'] as List<dynamic>? ?? const [];
    return CourseDetailDto(
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
      places:
          placeRows
              .map(
                (row) => CoursePlaceDto.fromJson(
                  Map<String, dynamic>.from(row as Map),
                ),
              )
              .toList()
            ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex)),
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
  final List<CoursePlaceDto> places;

  String get heroImageUrl {
    for (final place in places) {
      final url = place.heroImageUrl;
      if (url != null && url.isNotEmpty) return url;
    }
    return '';
  }
}
