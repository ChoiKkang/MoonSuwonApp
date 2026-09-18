import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CourseHistoryEntryDto;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository.dart'
    show MyPageRepository;

/// 오프라인/디버그 용도의 마이페이지 Mock 구현체.
///
/// 실제 앱에서는 [MyPageRepositorySupabase]가 주입되며, 이 Mock은
/// 위젯 테스트/오프라인 미리보기에서만 사용한다. 스키마는 실 서버 RPC
/// `public.list_user_course_history`가 반환하는 [CourseHistoryEntryDto]와
/// 동일한 형태를 유지해 UI 계약을 깨지 않는다.
class MyPageRepositoryMock implements MyPageRepository {
  static final CourseHistoryEntryDto _recentCourse = CourseHistoryEntryDto(
    progressId: '00000000-0000-0000-0000-000000000001',
    courseId: '00000000-0000-0000-0000-0000000000c0',
    courseSlug: 'course-date-01',
    heroTitle: '화성행궁 밤길 산책',
    subtitle: '첫 방문자를 위한 야경 입문 코스',
    routeSummary: null,
    heroImageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47',
    status: 'in_progress',
    startedAt: null,
    completedAt: null,
    checkinCount: 2,
    spotCount: 4,
    walkingDistanceKm: 1.2,
    estimatedDurationMin: 90,
  );

  @override
  Future<MyPageSummary> fetchSummaryAsync() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MyPageSummary(recentCourse: _recentCourse);
  }
}
