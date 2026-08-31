import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary, CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show
        CheckinMode,
        CheckinResult,
        CourseHistoryEntryDto,
        CourseProgressSessionDto;

abstract class CourseRepository {
  Future<List<CourseSummary>> fetchCoursesAsync();
  Future<CourseDetail> fetchCourseDetailAsync(String courseId);

  // ── 코스 진행률 (로그인 사용자 서버 저장) ──────────────────────────

  /// 코스 시작. `core.user_course_progress` row를 생성하고 progress_id를 반환한다.
  Future<CourseProgressSessionDto> startCourseProgressAsync(String courseId);

  /// 코스 완료. status='completed', completed_at=now() 처리.
  Future<CourseProgressSessionDto> completeCourseProgressAsync(
    String progressId,
  );

  /// 코스 중도 포기. status='abandoned' 처리.
  Future<void> abandonCourseProgressAsync(String progressId);

  /// 진행 중 세션(있으면)을 반환. 없으면 null.
  Future<CourseProgressSessionDto?> getActiveCourseProgressAsync(
    String courseId,
  );

  /// 스팟 체크인.
  Future<CheckinResult> checkinCoursePlaceAsync({
    required String progressId,
    required String placeId,
    required CheckinMode mode,
    double? lat,
    double? lng,
  });

  /// 로그인 사용자의 코스 진행 기록 목록.
  Future<List<CourseHistoryEntryDto>> listUserCourseHistoryAsync({
    int limit = 20,
  });
}
