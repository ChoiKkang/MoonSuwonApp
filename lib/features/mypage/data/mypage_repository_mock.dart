import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository.dart' show MyPageRepository;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart' show MyPageSummary;

class MyPageRepositoryMock implements MyPageRepository {
  static const _recentCourse = CourseSummary(
    id: 'course-date-01',
    title: '화성행궁 밤길 산책',
    subtitle: '첫 방문자를 위한 야경 입문 코스',
    estimatedDurationMin: 90,
    walkingDistanceKm: 1.2,
    recommendedStartTime: '18:30',
    spotCount: 4,
    heroImageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47',
    themeTags: ['date', 'night', 'beginner'],
  );

  @override
  Future<MyPageSummary> fetchSummaryAsync() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const MyPageSummary(
      favoriteSpotCount: 12,
      favoriteCourseCount: 3,
      recentCourse: _recentCourse,
      locationPermissionGranted: false,
      appVersion: 'v1.2.4',
    );
  }
}
