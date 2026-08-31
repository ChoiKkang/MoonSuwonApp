import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;

/// 마이페이지에서 필요한 최소 요약 정보.
///
/// 찜 카운트(스팟/코스)는 이 요약이 아니라 `favoriteSpots/CoursesProvider`에서
/// 직접 도출한다. 로그인/게스트 상태 전환 시 자동 갱신되도록 UI 측에서 provider를 watch한다.
class MyPageSummary {
  const MyPageSummary({
    required this.recentCourse,
    required this.locationPermissionGranted,
    required this.appVersion,
  });

  final CourseSummary? recentCourse;
  final bool locationPermissionGranted;
  final String appVersion;
}
