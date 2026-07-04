import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;

class MyPageSummary {
  const MyPageSummary({
    required this.nickname,
    required this.avatarUrl,
    required this.loginProviderLabel,
    required this.favoriteSpotCount,
    required this.favoriteCourseCount,
    required this.recentCourse,
    required this.locationPermissionGranted,
    required this.appVersion,
  });

  final String nickname;
  final String? avatarUrl;
  final String loginProviderLabel;
  final int favoriteSpotCount;
  final int favoriteCourseCount;
  final CourseSummary? recentCourse;
  final bool locationPermissionGranted;
  final String appVersion;
}
