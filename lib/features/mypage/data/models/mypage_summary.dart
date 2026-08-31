import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CourseHistoryEntryDto;

/// 마이페이지에서 필요한 최소 요약 정보.
///
/// - 찜 카운트(스팟/코스)는 `favoriteSpots/CoursesProvider`에서 도출.
/// - 위치 권한 상태는 `locationPermissionProvider`에서 조회.
/// - 알림 권한 상태는 `notificationPermissionProvider`에서 조회.
/// - 앱 버전은 `appVersionInfoProvider`에서 조회.
///
/// 여기서는 실제 서버(`public.list_user_course_history` RPC)에서 조회한
/// 최근 진행/완료 코스 1건만 담는다. 비로그인 사용자는 RPC가 빈 결과를
/// 반환하므로 [recentCourse]는 `null`이 되고 마이페이지 카드도 미노출된다.
class MyPageSummary {
  const MyPageSummary({required this.recentCourse});

  final CourseHistoryEntryDto? recentCourse;
}
