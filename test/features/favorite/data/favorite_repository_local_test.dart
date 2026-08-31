import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferencesAsync;
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart'
    show InMemorySharedPreferencesAsync;
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart'
    show SharedPreferencesAsyncPlatform;

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository_local.dart'
    show FavoriteRepositoryLocal;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('스팟을 저장하면 목록으로 조회되고 동일 스팟을 다시 저장해도 중복 저장되지 않는다', () async {
    // Given an empty local repository.
    final repo = FavoriteRepositoryLocal(prefs: SharedPreferencesAsync());
    const spot = FavoriteSpotSummary(
      placeId: 'b98a0000-0000-0000-0000-000000000001',
      slug: 'banghwasuryujeong',
      name: '방화수류정',
      category: 'heritage-night-view',
      heroImageUrl: 'https://example.com/hero.jpg',
      nightHighlight: '연못에 비친 달빛',
    );

    // When the same spot is added twice.
    await repo.addSpotAsync(spot);
    await repo.addSpotAsync(spot);

    // Then only a single record persists with the input fields intact.
    final spots = await repo.fetchFavoriteSpotsAsync();
    expect(spots, hasLength(1));
    expect(spots.single.placeId, spot.placeId);
    expect(spots.single.slug, 'banghwasuryujeong');
    expect(spots.single.name, '방화수류정');
    expect(spots.single.nightHighlight, '연못에 비친 달빛');
  });

  test('코스를 저장/조회/삭제하면 목록이 정확히 반영된다', () async {
    // Given a local repository with a single stored course.
    final repo = FavoriteRepositoryLocal(prefs: SharedPreferencesAsync());
    const course = FavoriteCourseSummary(
      courseId: 'c98a0000-0000-0000-0000-000000000001',
      slug: 'course-night-photo',
      title: '야경 사진 집중 코스',
      subtitle: '첫 방문자를 위한 야경 코스',
      routeSummary: '장안문 → 화홍문 → 방화수류정',
      estimatedDurationMin: 90,
      spotCount: 3,
      heroImageUrl: 'https://example.com/course-hero.jpg',
      themeTags: ['photo', 'night-view'],
    );
    await repo.addCourseAsync(course);

    // When the course is removed via a FavoriteTarget.
    await repo.removeAsync(
      const FavoriteTarget(
        type: FavoriteTargetType.course,
        id: 'c98a0000-0000-0000-0000-000000000001',
      ),
    );

    // Then no courses remain in the local repository.
    final courses = await repo.fetchFavoriteCoursesAsync();
    expect(courses, isEmpty);
  });

  test('존재하지 않는 대상을 삭제해도 예외를 던지지 않는다', () async {
    final repo = FavoriteRepositoryLocal(prefs: SharedPreferencesAsync());
    await repo.removeAsync(
      const FavoriteTarget(
        type: FavoriteTargetType.spot,
        id: 'non-existent-id',
      ),
    );
    expect(await repo.fetchFavoriteSpotsAsync(), isEmpty);
  });
}
