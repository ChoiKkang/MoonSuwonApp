import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;

class MyPageSummary {
  const MyPageSummary({
    required this.favoriteSpotCount,
    required this.favoriteCourseCount,
    required this.recentCourse,
    required this.locationPermissionGranted,
    required this.appVersion,
  });

  final int favoriteSpotCount;
  final int favoriteCourseCount;
  final CourseSummary? recentCourse;
  final bool locationPermissionGranted;
  final String appVersion;
}
