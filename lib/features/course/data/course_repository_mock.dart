import 'package:dalbit_suwon/features/course/data/course_repository.dart' show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary, CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot, SpotProgressStatus;

class CourseRepositoryMock implements CourseRepository {
  static const _baseImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47';

  static final _courses = [
    const CourseSummary(
      id: 'course-date-01',
      title: '처음 가는 수원화성\n데이트 코스',
      subtitle: '첫 방문자를 위한 야경 입문 코스',
      estimatedDurationMin: 90,
      walkingDistanceKm: 2.1,
      recommendedStartTime: '18:30',
      spotCount: 4,
      heroImageUrl: _baseImage,
      themeTags: ['date', 'night', 'beginner'],
    ),
    const CourseSummary(
      id: 'course-photo-01',
      title: '야경 사진 집중 코스',
      subtitle: '방화수류정과 용연 중심의 포토 데이트',
      estimatedDurationMin: 120,
      walkingDistanceKm: 2.8,
      recommendedStartTime: '19:00',
      spotCount: 3,
      heroImageUrl: _baseImage,
      themeTags: ['date', 'photo', 'night'],
    ),
    const CourseSummary(
      id: 'course-walk-01',
      title: '산책 후 행리단길\n마무리 코스',
      subtitle: '성곽 산책부터 카페까지 완성형 데이트',
      estimatedDurationMin: 150,
      walkingDistanceKm: 3.5,
      recommendedStartTime: '17:30',
      spotCount: 5,
      heroImageUrl: _baseImage,
      themeTags: ['date', 'walk', 'cafe'],
    ),
  ];

  static final _spotsByCourse = {
    'course-photo-01': [
      const Spot(
        id: 'spot-banghwasuryujeong',
        name: '방화수류정',
        summary: '수원화성 야경의 꽃',
        imageUrl: _baseImage,
        lat: 37.2870,
        lng: 127.0175,
        missionRadiusM: 80,
        missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
        status: SpotProgressStatus.completed,
      ),
      const Spot(
        id: 'spot-yongyeon',
        name: '용연',
        summary: '수면에 비친 달빛',
        imageUrl: _baseImage,
        lat: 37.2885,
        lng: 127.0168,
        missionRadiusM: 80,
        missionPrompt: '수면에 비친 반영을 담아보세요.',
        status: SpotProgressStatus.current,
      ),
      const Spot(
        id: 'spot-hwahongmun',
        name: '화홍문',
        summary: '7개의 물줄기 위 조명',
        imageUrl: _baseImage,
        lat: 37.2892,
        lng: 127.0160,
        missionRadiusM: 80,
        missionPrompt: '7개의 수문 아치를 한 프레임에 담아보세요.',
      ),
    ],
    'course-date-01': [
      const Spot(
        id: 'spot-hwaseonghaenggung',
        name: '화성행궁',
        summary: '조선 최대 행궁의 야경',
        imageUrl: _baseImage,
        lat: 37.2795,
        lng: 127.0133,
        missionRadiusM: 100,
        missionPrompt: '정문 신풍루를 배경으로 사진을 찍어보세요.',
      ),
      const Spot(
        id: 'spot-jangan',
        name: '장안문',
        summary: '화성의 북쪽 정문',
        imageUrl: _baseImage,
        lat: 37.2912,
        lng: 127.0148,
        missionRadiusM: 80,
        missionPrompt: '성문 아치 아래에서 위를 올려다보세요.',
      ),
      const Spot(
        id: 'spot-banghwasuryujeong',
        name: '방화수류정',
        summary: '수원화성 야경의 꽃',
        imageUrl: _baseImage,
        lat: 37.2870,
        lng: 127.0175,
        missionRadiusM: 80,
        missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
      ),
      const Spot(
        id: 'spot-yongyeon',
        name: '용연',
        summary: '수면에 비친 달빛',
        imageUrl: _baseImage,
        lat: 37.2885,
        lng: 127.0168,
        missionRadiusM: 80,
        missionPrompt: '수면에 비친 반영을 담아보세요.',
      ),
    ],
  };

  @override
  Future<List<CourseSummary>> fetchCoursesAsync() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _courses;
  }

  @override
  Future<CourseDetail> fetchCourseDetailAsync(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final summary = _courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => _courses.first,
    );
    final spots = _spotsByCourse[courseId] ?? _spotsByCourse['course-date-01']!;
    return CourseDetail(
      id: summary.id,
      title: summary.title,
      subtitle: summary.subtitle,
      description: '수원화성의 가장 아름다운 밤을 렌즈로 담는 여정입니다. 은은한 조명과 함께 고궁의 로맨틱한 밤을 담아보세요.',
      estimatedDurationMin: summary.estimatedDurationMin,
      walkingDistanceKm: summary.walkingDistanceKm,
      recommendedStartTime: summary.recommendedStartTime,
      heroImageUrl: summary.heroImageUrl,
      themeTags: summary.themeTags,
      spots: spots,
      petReadyFlag: summary.petReadyFlag,
    );
  }
}
