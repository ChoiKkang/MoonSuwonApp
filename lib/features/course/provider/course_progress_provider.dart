import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/course/data/models/course_progress_dto.dart'
    show CheckinMode, CheckinResult, CourseProgressSessionDto;
import 'package:dalbit_suwon/features/course/data/models/spot.dart'
    show Spot, SpotProgressStatus;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseRepositoryProvider;

part 'course_progress_provider.g.dart';

/// 현재 진행 중인 코스 세션의 상태.
///
/// - 로그인 사용자: `progressId`가 실제 `core.user_course_progress.id` (UUID).
/// - 게스트(비로그인): `progressId`는 null이며, 서버 저장 없이 로컬로만 진행한다.
///
/// UI는 이 클래스만 관찰하면 되고, 서버 저장 여부/성공 여부는 Notifier가 담당한다.
class CourseProgressState {
  const CourseProgressState({
    this.courseId,
    this.progressId,
    this.spots = const [],
    this.currentIndex = 0,
    this.checkedPlaceIds = const {},
    this.isSyncing = false,
    this.errorMessage,
    this.completedAt,
    this.isPerfect = false,
  });

  const CourseProgressState.idle() : this();

  final String? courseId;
  final String? progressId;
  final List<Spot> spots;
  final int currentIndex;
  final Set<String> checkedPlaceIds;
  final bool isSyncing;
  final String? errorMessage;
  final DateTime? completedAt;
  final bool isPerfect;

  bool get isActive => courseId != null && spots.isNotEmpty;
  bool get isCompletedByIndex =>
      spots.isNotEmpty && currentIndex >= spots.length;
  bool get isServerSynced => progressId != null;

  Spot? get currentSpot =>
      currentIndex >= 0 && currentIndex < spots.length
          ? spots[currentIndex]
          : null;

  CourseProgressState copyWith({
    String? courseId,
    String? progressId,
    List<Spot>? spots,
    int? currentIndex,
    Set<String>? checkedPlaceIds,
    bool? isSyncing,
    String? errorMessage,
    DateTime? completedAt,
    bool? isPerfect,
    bool clearError = false,
    bool clearCompletedAt = false,
    bool clearProgressId = false,
  }) {
    return CourseProgressState(
      courseId: courseId ?? this.courseId,
      progressId: clearProgressId ? null : (progressId ?? this.progressId),
      spots: spots ?? this.spots,
      currentIndex: currentIndex ?? this.currentIndex,
      checkedPlaceIds: checkedPlaceIds ?? this.checkedPlaceIds,
      isSyncing: isSyncing ?? this.isSyncing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      completedAt: clearCompletedAt ? null : (completedAt ?? this.completedAt),
      isPerfect: isPerfect ?? this.isPerfect,
    );
  }
}

@riverpod
class CourseProgressNotifier extends _$CourseProgressNotifier {
  @override
  CourseProgressState build() {
    // 코스 시작 → 진행 → 완료 흐름은 여러 페이지에 걸쳐 있고,
    // 각 페이지가 이 프로바이더를 항상 watch하지는 않는다 (예: 코스 상세는 ref.read만).
    // AutoDispose 기본값이면 첫 RPC 대기 중에 dispose되어 상태 갱신이 폭발하므로
    // 세션 전 구간에서 강제로 keepAlive 시킨다. reset()으로 명시적으로 초기화한다.
    ref.keepAlive();
    return const CourseProgressState.idle();
  }

  bool get _isLoggedIn {
    // Supabase 세션이 살아 있으면 서버 저장 대상이다.
    // authNotifierProvider는 세션 이벤트를 이미 구독 중이라 최신 값을 반환한다.
    return ref.read(authNotifierProvider);
  }

  /// 코스 상세 로드 이후, "코스 시작하기" 시점에 호출한다.
  ///
  /// - 로그인 상태: `start_course_progress` RPC 호출 → progress_id 저장.
  /// - 비로그인 상태: 서버 호출 없이 로컬 세션만 시작.
  Future<void> startCourseAsync({
    required String courseId,
    required List<Spot> spots,
  }) async {
    if (spots.isEmpty) return;

    // 초기화
    state = CourseProgressState(
      courseId: courseId,
      spots: spots,
      currentIndex: 0,
      checkedPlaceIds: const {},
      isSyncing: _isLoggedIn,
    );

    if (!_isLoggedIn) {
      // 게스트 흐름: 서버 저장은 스펙상 로컬 저장 범위. 그대로 유지.
      state = state.copyWith(isSyncing: false);
      return;
    }

    try {
      final session = await ref
          .read(courseRepositoryProvider)
          .startCourseProgressAsync(courseId);
      state = state.copyWith(
        progressId: session.progressId,
        isSyncing: false,
        clearError: true,
      );
    } on Object catch (error) {
      // 서버 저장 실패해도 로컬 진행은 이어갈 수 있게 한다.
      state = state.copyWith(
        isSyncing: false,
        errorMessage: '진행 상태 저장 실패: $error',
      );
    }
  }

  /// 현재 스팟(도착 확인) 체크인 처리.
  ///
  /// - 로그인 & progressId가 있으면 `checkin_place` RPC 호출.
  /// - 게스트/서버 실패는 로컬 인덱스만 진행.
  /// - 성공/이미 체크인된 경우 currentIndex를 다음으로 이동.
  Future<CheckinResult> checkinCurrentSpotAsync({
    CheckinMode mode = CheckinMode.manual,
    double? lat,
    double? lng,
  }) async {
    final s = state;
    if (!s.isActive || s.isCompletedByIndex) return CheckinResult.unknown;
    final spot = s.currentSpot;
    if (spot == null) return CheckinResult.unknown;

    // 로컬 인덱스는 낙관적으로 먼저 진행시켜 UX가 끊기지 않게 한다.
    final nextIndex = s.currentIndex + 1;
    final nextChecked = {...s.checkedPlaceIds, spot.id};

    if (!_isLoggedIn || s.progressId == null) {
      state = s.copyWith(
        currentIndex: nextIndex,
        checkedPlaceIds: nextChecked,
      );
      return CheckinResult.success;
    }

    state = s.copyWith(isSyncing: true, clearError: true);
    try {
      final result = await ref
          .read(courseRepositoryProvider)
          .checkinCoursePlaceAsync(
            progressId: s.progressId!,
            placeId: spot.id,
            mode: mode,
            lat: lat,
            lng: lng,
          );
      state = state.copyWith(
        currentIndex: nextIndex,
        checkedPlaceIds: nextChecked,
        isSyncing: false,
      );
      return result;
    } on Object catch (error) {
      // 서버 실패해도 UX는 계속. 다음 스팟으로 진행.
      state = state.copyWith(
        currentIndex: nextIndex,
        checkedPlaceIds: nextChecked,
        isSyncing: false,
        errorMessage: '체크인 저장 실패: $error',
      );
      return CheckinResult.unknown;
    }
  }

  /// 코스 완료 처리. 완료 화면 진입 시 호출한다.
  /// 로그인 & progressId가 있으면 `complete_course_progress` RPC를 부른다.
  Future<void> completeCourseAsync() async {
    final s = state;
    if (!s.isActive) return;

    if (!_isLoggedIn || s.progressId == null) {
      state = s.copyWith(
        completedAt: DateTime.now(),
        isPerfect: s.checkedPlaceIds.length >= s.spots.length,
      );
      return;
    }

    state = s.copyWith(isSyncing: true, clearError: true);
    try {
      final CourseProgressSessionDto session = await ref
          .read(courseRepositoryProvider)
          .completeCourseProgressAsync(s.progressId!);
      state = state.copyWith(
        completedAt: session.completedAt ?? DateTime.now(),
        isPerfect: session.isPerfect,
        isSyncing: false,
      );
    } on Object catch (error) {
      state = state.copyWith(
        completedAt: DateTime.now(),
        isPerfect: state.checkedPlaceIds.length >= state.spots.length,
        isSyncing: false,
        errorMessage: '완료 저장 실패: $error',
      );
    }
  }

  /// 사용자가 중도 이탈할 때 호출.
  Future<void> abandonCourseAsync() async {
    final s = state;
    if (!s.isServerSynced || !_isLoggedIn) {
      state = const CourseProgressState.idle();
      return;
    }
    try {
      await ref
          .read(courseRepositoryProvider)
          .abandonCourseProgressAsync(s.progressId!);
    } on Object {
      // 소리 없이 실패해도 로컬 세션은 초기화한다.
    }
    state = const CourseProgressState.idle();
  }

  /// 현재 스팟 완료(체크인 없이 인덱스만 증가). 하위 호환 목적으로 유지.
  ///
  /// 새 코드는 `checkinCurrentSpotAsync`를 사용해야 한다.
  void completeCurrentSpot() {
    final s = state;
    if (!s.isActive || s.isCompletedByIndex) return;
    final spot = s.currentSpot;
    state = s.copyWith(
      currentIndex: s.currentIndex + 1,
      checkedPlaceIds:
          spot == null ? s.checkedPlaceIds : {...s.checkedPlaceIds, spot.id},
    );
  }

  void reset() {
    state = const CourseProgressState.idle();
  }
}

@riverpod
class ArrivalModalNotifier extends _$ArrivalModalNotifier {
  @override
  bool build() => false;

  void show() => state = true;
  void hide() => state = false;
}

SpotProgressStatus statusForIndex(int currentIndex, int spotIndex) {
  if (spotIndex < currentIndex) return SpotProgressStatus.completed;
  if (spotIndex == currentIndex) return SpotProgressStatus.current;
  return SpotProgressStatus.pending;
}
