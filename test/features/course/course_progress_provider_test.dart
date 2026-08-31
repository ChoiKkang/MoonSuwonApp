import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show AuthNotifier, authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseDetail, CourseSummary;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show
        CheckinMode,
        CheckinResult,
        CourseHistoryEntryDto,
        CourseProgressSessionDto;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;
import 'package:dalbit_suwon/features/course/provider/course_progress_provider.dart'
    show courseProgressNotifierProvider;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseRepositoryProvider;

/// authNotifierProvider가 세션 상태를 반환하므로, 테스트에서 override할 수 있게
/// 로컬 Notifier를 하나 준비한다.
class _StaticAuthNotifier extends AuthNotifier {
  _StaticAuthNotifier(this._isLoggedIn);
  final bool _isLoggedIn;
  @override
  bool build() => _isLoggedIn;
}

void main() {
  const String courseId = '11111111-1111-1111-1111-111111111111';
  const String placeAId = '22222222-2222-2222-2222-222222222222';
  const String placeBId = '33333333-3333-3333-3333-333333333333';

  const spots = [
    Spot(
      id: placeAId,
      name: '팔달문',
      summary: '남쪽 정문',
      imageUrl: '',
      lat: 37.2782,
      lng: 127.0169,
      missionRadiusM: 100,
      missionPrompt: 'A',
    ),
    Spot(
      id: placeBId,
      name: '화성행궁',
      summary: '행궁 야경',
      imageUrl: '',
      lat: 37.2810,
      lng: 127.0135,
      missionRadiusM: 100,
      missionPrompt: 'B',
    ),
  ];

  test('로그인 사용자는 startCourse → checkin → complete RPC를 순서대로 호출한다',
      () async {
    final repo = _RecordingCourseRepository();
    final container = ProviderContainer(overrides: [
      courseRepositoryProvider.overrideWithValue(repo),
      authNotifierProvider.overrideWith(() => _StaticAuthNotifier(true)),
    ]);
    addTearDown(container.dispose);

    final notifier =
        container.read(courseProgressNotifierProvider.notifier);

    await notifier.startCourseAsync(courseId: courseId, spots: spots);
    expect(repo.startedCourseIds, [courseId]);
    expect(
      container.read(courseProgressNotifierProvider).progressId,
      'progress-1',
    );

    final r1 = await notifier.checkinCurrentSpotAsync();
    expect(r1, CheckinResult.success);
    expect(repo.checkins, [placeAId]);
    expect(container.read(courseProgressNotifierProvider).currentIndex, 1);

    final r2 = await notifier.checkinCurrentSpotAsync();
    expect(r2, CheckinResult.success);
    expect(repo.checkins, [placeAId, placeBId]);
    expect(container.read(courseProgressNotifierProvider).currentIndex, 2);
    expect(
      container.read(courseProgressNotifierProvider).isCompletedByIndex,
      true,
    );

    await notifier.completeCourseAsync();
    expect(repo.completedProgressIds, ['progress-1']);
    final state = container.read(courseProgressNotifierProvider);
    expect(state.completedAt, isNotNull);
    expect(state.isPerfect, true);
  });

  test('게스트(비로그인) 사용자는 서버 RPC를 호출하지 않고 로컬로만 진행한다', () async {
    final repo = _RecordingCourseRepository();
    final container = ProviderContainer(overrides: [
      courseRepositoryProvider.overrideWithValue(repo),
      authNotifierProvider.overrideWith(() => _StaticAuthNotifier(false)),
    ]);
    addTearDown(container.dispose);

    final notifier =
        container.read(courseProgressNotifierProvider.notifier);

    await notifier.startCourseAsync(courseId: courseId, spots: spots);
    expect(repo.startedCourseIds, isEmpty);
    expect(
      container.read(courseProgressNotifierProvider).progressId,
      isNull,
    );

    await notifier.checkinCurrentSpotAsync();
    await notifier.checkinCurrentSpotAsync();
    expect(repo.checkins, isEmpty);
    expect(container.read(courseProgressNotifierProvider).currentIndex, 2);

    await notifier.completeCourseAsync();
    expect(repo.completedProgressIds, isEmpty);
    expect(
      container.read(courseProgressNotifierProvider).completedAt,
      isNotNull,
    );
  });

  test('서버 저장 실패 시에도 로컬 진행은 이어진다', () async {
    final repo = _RecordingCourseRepository(shouldThrow: true);
    final container = ProviderContainer(overrides: [
      courseRepositoryProvider.overrideWithValue(repo),
      authNotifierProvider.overrideWith(() => _StaticAuthNotifier(true)),
    ]);
    addTearDown(container.dispose);

    final notifier =
        container.read(courseProgressNotifierProvider.notifier);

    await notifier.startCourseAsync(courseId: courseId, spots: spots);
    expect(
      container.read(courseProgressNotifierProvider).errorMessage,
      contains('진행 상태 저장 실패'),
    );
    // 서버 실패해도 spots는 세팅되어 있어야 한다.
    expect(container.read(courseProgressNotifierProvider).spots.length, 2);
  });
}

class _RecordingCourseRepository implements CourseRepository {
  _RecordingCourseRepository({this.shouldThrow = false});

  final bool shouldThrow;
  final startedCourseIds = <String>[];
  final checkins = <String>[];
  final completedProgressIds = <String>[];

  int _seq = 0;

  @override
  Future<CourseProgressSessionDto> startCourseProgressAsync(
    String courseId,
  ) async {
    if (shouldThrow) throw StateError('boom');
    _seq += 1;
    startedCourseIds.add(courseId);
    return CourseProgressSessionDto(
      progressId: 'progress-$_seq',
      courseId: courseId,
      status: 'in_progress',
      startedAt: DateTime(2026, 8, 31),
    );
  }

  @override
  Future<CheckinResult> checkinCoursePlaceAsync({
    required String progressId,
    required String placeId,
    required CheckinMode mode,
    double? lat,
    double? lng,
  }) async {
    checkins.add(placeId);
    return CheckinResult.success;
  }

  @override
  Future<CourseProgressSessionDto> completeCourseProgressAsync(
    String progressId,
  ) async {
    completedProgressIds.add(progressId);
    return CourseProgressSessionDto(
      progressId: progressId,
      courseId: '11111111-1111-1111-1111-111111111111',
      status: 'completed',
      startedAt: DateTime(2026, 8, 31),
      completedAt: DateTime(2026, 8, 31, 2),
      checkinCount: checkins.length,
      spotCount: 2,
      isPerfect: checkins.length >= 2,
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
  Future<List<CourseHistoryEntryDto>> listUserCourseHistoryAsync({
    int limit = 20,
  }) async =>
      const [];

  @override
  Future<List<CourseSummary>> fetchCoursesAsync() async => const [];

  @override
  Future<CourseDetail> fetchCourseDetailAsync(String courseId) async =>
      const CourseDetail(
        id: 'x',
        title: 'x',
        subtitle: 'x',
        description: 'x',
        estimatedDurationMin: 0,
        walkingDistanceKm: 0,
        recommendedStartTime: '',
        heroImageUrl: '',
        themeTags: [],
        spots: [],
      );
}
