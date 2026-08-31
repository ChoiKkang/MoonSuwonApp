import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary, CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;

/// 로컬(Mock) 코스/스팟 데이터.
///
/// 기획안(2026-05-25 MVP 6.1/6.2, 11.1/11.2) 기준으로 수원화성 일대의
/// 야간 체험 스팟 10개를 스팟 풀로 정의하고, 추천 코스 3종을 이 풀에서 편성한다.
/// 좌표는 WGS84(경도 lng, 위도 lat) 기준이며 각 스팟의 대표 지점 값이다.
class CourseRepositoryMock implements CourseRepository {
  static const _baseImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47';

  // ──────────────────────────────────────────────────────────
  // 스팟 풀 — 기획안 6.2 초기 스팟 풀 (수원화성 일대 10개 지점)
  // ──────────────────────────────────────────────────────────

  static const _hwaseongHaenggung = Spot(
    id: 'spot-hwaseonghaenggung',
    name: '화성행궁',
    summary: '조선 최대 행궁의 야경',
    imageUrl: _baseImage,
    lat: 37.2810,
    lng: 127.0135,
    // 개방형 광장 — 반경 완화(100m)
    missionRadiusM: 100,
    missionPrompt: '정문 신풍루를 배경으로 사진을 찍어보세요.',
  );

  static const _hwahongmun = Spot(
    id: 'spot-hwahongmun',
    name: '화홍문',
    summary: '7개의 물줄기 위 조명',
    imageUrl: _baseImage,
    lat: 37.2865,
    lng: 127.0169,
    missionRadiusM: 80,
    missionPrompt: '7개의 수문 아치를 한 프레임에 담아보세요.',
  );

  static const _banghwasuryujeong = Spot(
    id: 'spot-banghwasuryujeong',
    name: '방화수류정',
    summary: '수원화성 야경의 꽃',
    imageUrl: _baseImage,
    lat: 37.2872,
    lng: 127.0176,
    missionRadiusM: 80,
    missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
  );

  static const _yongyeon = Spot(
    id: 'spot-yongyeon',
    name: '용연',
    summary: '수면에 비친 달빛',
    imageUrl: _baseImage,
    lat: 37.2879,
    lng: 127.0180,
    missionRadiusM: 80,
    missionPrompt: '수면에 비친 반영을 담아보세요.',
  );

  static const _janganmun = Spot(
    id: 'spot-janganmun',
    name: '장안문',
    summary: '화성의 북쪽 정문',
    imageUrl: _baseImage,
    lat: 37.2884,
    lng: 127.0130,
    // 성문 출입 포인트가 분명 — 반경 완화(100m)
    missionRadiusM: 100,
    missionPrompt: '성문 아치 아래에서 위를 올려다보세요.',
  );

  static const _changnyongmun = Spot(
    id: 'spot-changnyongmun',
    name: '창룡문',
    summary: '화성의 동쪽 성문',
    imageUrl: _baseImage,
    lat: 37.2836,
    lng: 127.0230,
    missionRadiusM: 100,
    missionPrompt: '옹성 안쪽에서 성문의 곡선을 따라 걸어보세요.',
  );

  static const _yeonmudae = Spot(
    id: 'spot-yeonmudae',
    name: '연무대',
    summary: '군사 훈련장의 야경',
    imageUrl: _baseImage,
    lat: 37.2842,
    lng: 127.0223,
    missionRadiusM: 100,
    missionPrompt: '동북공심돈의 원형 성곽을 한 컷에 담아보세요.',
  );

  static const _seojangdae = Spot(
    id: 'spot-seojangdae',
    name: '서장대',
    summary: '팔달산 정상의 야경 전망',
    imageUrl: _baseImage,
    lat: 37.2796,
    lng: 127.0100,
    // 개방형 성곽 정상 구간 — 반경 완화(100m)
    missionRadiusM: 100,
    missionPrompt: '정상에서 수원 시내 야경을 파노라마로 담아보세요.',
  );

  static const _paldalmun = Spot(
    id: 'spot-paldalmun',
    name: '팔달문',
    summary: '화성의 남쪽 정문',
    imageUrl: _baseImage,
    lat: 37.2782,
    lng: 127.0169,
    missionRadiusM: 100,
    missionPrompt: '로터리 한가운데 선 성문의 조명을 담아보세요.',
  );

  static const _haengridangil = Spot(
    id: 'spot-haengridangil',
    name: '행리단길',
    summary: '카페와 디저트로 마무리',
    imageUrl: _baseImage,
    lat: 37.2807,
    lng: 127.0155,
    // 밀집 상권 골목 — 반경 좁힘(60m)
    missionRadiusM: 60,
    missionPrompt: '마음에 드는 카페를 하나 골라 오늘 밤을 마무리해보세요.',
    petPolicy: 'partial',
    petNote: '가게별 반려동물 정책이 다르니 입장 전 확인하세요.',
  );

  // ──────────────────────────────────────────────────────────
  // 추천 코스 3종 — 기획안 6.1
  // ──────────────────────────────────────────────────────────

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
      spotCount: 4,
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

  static const _descriptionByCourse = {
    'course-date-01':
        '수원화성을 처음 방문하는 커플을 위한 입문 코스입니다. 대표 야경 명소를 무리 없는 동선으로 이어 붙여, 첫 방문에도 편안하게 화성의 밤을 즐길 수 있습니다.',
    'course-photo-01':
        '수원화성의 가장 아름다운 밤을 렌즈로 담는 여정입니다. 은은한 조명과 함께 고궁의 로맨틱한 밤을 담아보세요.',
    'course-walk-01':
        '성곽을 따라 여유롭게 걸으며 야경을 감상하고, 마지막에는 행리단길 카페에서 하루를 마무리하는 완성형 데이트 코스입니다.',
  };

  static final _spotsByCourse = <String, List<Spot>>{
    // 야경 사진 집중 코스: 장안문 → 화홍문 → 방화수류정 → 용연
    'course-photo-01': [_janganmun, _hwahongmun, _banghwasuryujeong, _yongyeon],
    // 처음 가는 데이트 코스: 팔달문 → 화성행궁 → 장안문 → 방화수류정
    'course-date-01': [
      _paldalmun,
      _hwaseongHaenggung,
      _janganmun,
      _banghwasuryujeong,
    ],
    // 산책 후 행리단길 마무리 코스:
    // 연무대 → 창룡문 → 서장대 → 방화수류정 → 행리단길
    'course-walk-01': [
      _yeonmudae,
      _changnyongmun,
      _seojangdae,
      _banghwasuryujeong,
      _haengridangil,
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
    final spots =
        _spotsByCourse[summary.id] ?? _spotsByCourse['course-date-01']!;
    return CourseDetail(
      id: summary.id,
      title: summary.title,
      subtitle: summary.subtitle,
      description:
          _descriptionByCourse[summary.id] ??
          _descriptionByCourse['course-date-01']!,
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
