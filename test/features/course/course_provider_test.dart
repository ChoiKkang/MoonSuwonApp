import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary, CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show
        CheckinMode,
        CheckinResult,
        CourseHistoryEntryDto,
        CourseProgressSessionDto;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseRepositoryProvider, coursesProvider, courseDetailProvider;

void main() {
  test('코스 목록과 상세가 동일한 주입 Repository를 사용한다', () async {
    final repository = _FakeCourseRepository();
    final container = ProviderContainer(
      overrides: [courseRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final courses = await container.read(coursesProvider.future);
    final detail = await container.read(
      courseDetailProvider('course-date-01').future,
    );

    expect(courses.single.id, 'live-course-id');
    expect(detail.id, 'course-date-01');
    expect(repository.fetchCoursesCallCount, 1);
    expect(repository.requestedCourseIds, ['course-date-01']);
  });
}

class _FakeCourseRepository implements CourseRepository {
  int fetchCoursesCallCount = 0;
  final requestedCourseIds = <String>[];

  @override
  Future<List<CourseSummary>> fetchCoursesAsync() async {
    fetchCoursesCallCount += 1;
    return const [
      CourseSummary(
        id: 'live-course-id',
        title: '실제 코스',
        subtitle: 'Supabase 코스',
        estimatedDurationMin: 90,
        walkingDistanceKm: 2.1,
        recommendedStartTime: '18:30',
        spotCount: 0,
        heroImageUrl: 'https://example.com/course.jpg',
        themeTags: ['date'],
      ),
    ];
  }

  @override
  Future<CourseDetail> fetchCourseDetailAsync(String courseId) async {
    requestedCourseIds.add(courseId);
    return CourseDetail(
      id: courseId,
      title: '실제 코스',
      subtitle: 'Supabase 코스',
      description: 'RPC 상세',
      estimatedDurationMin: 90,
      walkingDistanceKm: 2.1,
      recommendedStartTime: '18:30',
      heroImageUrl: 'https://example.com/course.jpg',
      themeTags: const ['date'],
      spots: const [],
    );
  }

  // 진행률 관련은 이 파일의 테스트 범위 밖이라 스텁만 구현.
  @override
  Future<CourseProgressSessionDto> startCourseProgressAsync(
    String courseId,
  ) async {
    return CourseProgressSessionDto(
      progressId: 'fake-progress',
      courseId: courseId,
      status: 'in_progress',
      startedAt: DateTime(2026, 8, 31),
    );
  }

  @override
  Future<CourseProgressSessionDto> completeCourseProgressAsync(
    String progressId,
  ) async {
    return CourseProgressSessionDto(
      progressId: progressId,
      courseId: 'course-date-01',
      status: 'completed',
      startedAt: DateTime(2026, 8, 31),
      completedAt: DateTime(2026, 8, 31, 1),
      checkinCount: 0,
      spotCount: 0,
    );
  }

  @override
  Future<void> abandonCourseProgressAsync(String progressId) async {}

  @override
  Future<CourseProgressSessionDto?> getActiveCourseProgressAsync(
    String courseId,
  ) async =>
      null;

  @override
  Future<CheckinResult> checkinCoursePlaceAsync({
    required String progressId,
    required String placeId,
    required CheckinMode mode,
    double? lat,
    double? lng,
  }) async =>
      CheckinResult.success;

  @override
  Future<List<CourseHistoryEntryDto>> listUserCourseHistoryAsync({
    int limit = 20,
  }) async =>
      const [];
}
