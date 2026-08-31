import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CourseHistoryEntryDto;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository.dart'
    show MyPageRepository;

/// 실제 Supabase에서 마이페이지 요약 데이터를 조회하는 구현체.
///
/// 최근 진행 코스는 `public.list_user_course_history(p_limit)` RPC를 호출해
/// 최신 1건을 사용한다. 이 RPC는 `auth.uid()` 기반으로 본인 데이터만
/// 반환하며, 비로그인(anon) 사용자는 빈 결과를 얻는다.
///
/// 마이페이지 특성상 서버 왕복은 최근 코스 1건이면 충분하므로 `limit=1`로
/// 요청해 페이로드를 최소화한다.
class MyPageRepositorySupabase implements MyPageRepository {
  const MyPageRepositorySupabase(this._courseRepository);

  final CourseRepository _courseRepository;

  @override
  Future<MyPageSummary> fetchSummaryAsync() async {
    final history =
        await _courseRepository.listUserCourseHistoryAsync(limit: 1);
    final CourseHistoryEntryDto? recent = history.isEmpty ? null : history.first;
    return MyPageSummary(recentCourse: recent);
  }
}
