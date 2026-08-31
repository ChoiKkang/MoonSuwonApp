/// 찜 목록에 표시할 코스 요약 정보.
///
/// `serving.v_home_courses`의 hero_title/subtitle/route_summary를 그대로 반영한다.
class FavoriteCourseSummary {
  const FavoriteCourseSummary({
    required this.courseId,
    required this.slug,
    required this.title,
    this.subtitle,
    this.routeSummary,
    required this.estimatedDurationMin,
    required this.spotCount,
    required this.heroImageUrl,
    required this.themeTags,
  });

  final String courseId;
  final String slug;
  final String title;
  final String? subtitle;
  final String? routeSummary;
  final int estimatedDurationMin;
  final int spotCount;
  final String heroImageUrl;
  final List<String> themeTags;
}
