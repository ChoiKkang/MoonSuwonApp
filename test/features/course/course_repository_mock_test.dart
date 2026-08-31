import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/course/data/course_repository_mock.dart'
    show CourseRepositoryMock;

void main() {
  late CourseRepositoryMock repository;

  setUp(() => repository = CourseRepositoryMock());

  group('CourseRepositoryMock.fetchCoursesAsync', () {
    test('추천 코스 3종을 반환한다', () async {
      final courses = await repository.fetchCoursesAsync();

      expect(courses, hasLength(3));
      expect(
        courses.map((c) => c.id),
        containsAll(['course-date-01', 'course-photo-01', 'course-walk-01']),
      );
    });

    test('각 코스의 spotCount가 실제 스팟 수와 일치한다', () async {
      final courses = await repository.fetchCoursesAsync();

      for (final course in courses) {
        final detail = await repository.fetchCourseDetailAsync(course.id);
        expect(
          detail.spots.length,
          course.spotCount,
          reason:
              '${course.id}의 spotCount(${course.spotCount})와 '
              '실제 스팟 수(${detail.spots.length})가 다릅니다.',
        );
      }
    });
  });

  group('CourseRepositoryMock.fetchCourseDetailAsync', () {
    test('3개 코스 모두 고유한 스팟 리스트를 갖는다 (fallback 없음)', () async {
      final date = await repository.fetchCourseDetailAsync('course-date-01');
      final photo = await repository.fetchCourseDetailAsync('course-photo-01');
      final walk = await repository.fetchCourseDetailAsync('course-walk-01');

      expect(date.spots.map((s) => s.id).toList(), [
        'spot-paldalmun',
        'spot-hwaseonghaenggung',
        'spot-janganmun',
        'spot-banghwasuryujeong',
      ]);
      expect(photo.spots.map((s) => s.id).toList(), [
        'spot-janganmun',
        'spot-hwahongmun',
        'spot-banghwasuryujeong',
        'spot-yongyeon',
      ]);
      expect(walk.spots.map((s) => s.id).toList(), [
        'spot-yeonmudae',
        'spot-changnyongmun',
        'spot-seojangdae',
        'spot-banghwasuryujeong',
        'spot-haengridangil',
      ]);
    });

    test('각 코스 내 스팟 id는 중복되지 않는다', () async {
      for (final id in [
        'course-date-01',
        'course-photo-01',
        'course-walk-01',
      ]) {
        final detail = await repository.fetchCourseDetailAsync(id);
        final ids = detail.spots.map((s) => s.id).toList();
        expect(
          ids.toSet(),
          hasLength(ids.length),
          reason: '$id 코스에 중복 스팟이 있습니다.',
        );
      }
    });

    test('모든 스팟은 유효한 수원화성 좌표와 미션 반경을 갖는다', () async {
      for (final id in [
        'course-date-01',
        'course-photo-01',
        'course-walk-01',
      ]) {
        final detail = await repository.fetchCourseDetailAsync(id);
        for (final spot in detail.spots) {
          // 수원화성 일대 대략 경계
          expect(spot.lat, inInclusiveRange(37.27, 37.30));
          expect(spot.lng, inInclusiveRange(127.00, 127.03));
          expect(spot.missionRadiusM, greaterThan(0));
          expect(spot.missionPrompt, isNotEmpty);
        }
      }
    });

    test('description이 코스별로 채워져 있다', () async {
      final photo = await repository.fetchCourseDetailAsync('course-photo-01');
      final walk = await repository.fetchCourseDetailAsync('course-walk-01');

      expect(photo.description, isNotEmpty);
      expect(walk.description, isNotEmpty);
      expect(photo.description, isNot(equals(walk.description)));
    });
  });
}
