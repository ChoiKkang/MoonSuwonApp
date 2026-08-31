import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary;

/// 마이페이지에서 필요한 최소 요약 정보.
///
/// - 찜 카운트(스팟/코스)는 `favoriteSpots/CoursesProvider`에서 도출.
/// - 위치 권한 상태는 `locationPermissionProvider`에서 조회.
/// - 알림 권한 상태는 `notificationPermissionProvider`에서 조회.
/// - 앱 버전은 `appVersionInfoProvider`에서 조회.
/// 여기서는 최근 진행 코스만 노출한다.
class MyPageSummary {
  const MyPageSummary({required this.recentCourse});

  final CourseSummary? recentCourse;
}
