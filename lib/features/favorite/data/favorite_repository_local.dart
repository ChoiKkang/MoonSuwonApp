import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferencesAsync;

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

/// 게스트(비로그인) 상태에서 사용하는 로컬 저장소.
///
/// SharedPreferences에 JSON 문자열로 스팟/코스 각각을 저장한다.
/// 로그인 시에는 `FavoriteRepositorySupabase`로 대체된다.
class FavoriteRepositoryLocal implements FavoriteRepository {
  FavoriteRepositoryLocal({SharedPreferencesAsync? prefs})
    : _prefs = prefs ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _prefs;

  static const _kSpotsKey = 'favorite.spots';
  static const _kCoursesKey = 'favorite.courses';

  @override
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync() async {
    final raw = await _prefs.getString(_kSpotsKey);
    if (raw == null || raw.isEmpty) return const [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => _spotFromMap(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  @override
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync() async {
    final raw = await _prefs.getString(_kCoursesKey);
    if (raw == null || raw.isEmpty) return const [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => _courseFromMap(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  @override
  Future<void> addSpotAsync(FavoriteSpotSummary spot) async {
    final current = await fetchFavoriteSpotsAsync();
    if (current.any((s) => s.placeId == spot.placeId)) return;
    final next = [spot, ...current];
    await _prefs.setString(
      _kSpotsKey,
      jsonEncode(next.map(_spotToMap).toList()),
    );
  }

  @override
  Future<void> addCourseAsync(FavoriteCourseSummary course) async {
    final current = await fetchFavoriteCoursesAsync();
    if (current.any((c) => c.courseId == course.courseId)) return;
    final next = [course, ...current];
    await _prefs.setString(
      _kCoursesKey,
      jsonEncode(next.map(_courseToMap).toList()),
    );
  }

  @override
  Future<void> removeAsync(FavoriteTarget target) async {
    switch (target.type) {
      case FavoriteTargetType.spot:
        final current = await fetchFavoriteSpotsAsync();
        final next = current.where((s) => s.placeId != target.id).toList();
        await _prefs.setString(
          _kSpotsKey,
          jsonEncode(next.map(_spotToMap).toList()),
        );
      case FavoriteTargetType.course:
        final current = await fetchFavoriteCoursesAsync();
        final next = current.where((c) => c.courseId != target.id).toList();
        await _prefs.setString(
          _kCoursesKey,
          jsonEncode(next.map(_courseToMap).toList()),
        );
    }
  }

  Map<String, dynamic> _spotToMap(FavoriteSpotSummary s) => {
    'place_id': s.placeId,
    'slug': s.slug,
    'name': s.name,
    'category': s.category,
    'hero_image_url': s.heroImageUrl,
    'night_highlight': s.nightHighlight,
  };

  FavoriteSpotSummary _spotFromMap(Map<String, dynamic> m) =>
      FavoriteSpotSummary(
        placeId: m['place_id'] as String,
        slug: m['slug'] as String,
        name: m['name'] as String,
        category: m['category'] as String? ?? 'heritage-night-view',
        heroImageUrl: m['hero_image_url'] as String? ?? '',
        nightHighlight: m['night_highlight'] as String?,
      );

  Map<String, dynamic> _courseToMap(FavoriteCourseSummary c) => {
    'course_id': c.courseId,
    'slug': c.slug,
    'title': c.title,
    'subtitle': c.subtitle,
    'route_summary': c.routeSummary,
    'estimated_duration_min': c.estimatedDurationMin,
    'spot_count': c.spotCount,
    'hero_image_url': c.heroImageUrl,
    'theme_tags': c.themeTags,
  };

  FavoriteCourseSummary _courseFromMap(Map<String, dynamic> m) =>
      FavoriteCourseSummary(
        courseId: m['course_id'] as String,
        slug: m['slug'] as String,
        title: m['title'] as String,
        subtitle: m['subtitle'] as String?,
        routeSummary: m['route_summary'] as String?,
        estimatedDurationMin:
            (m['estimated_duration_min'] as num?)?.toInt() ?? 0,
        spotCount: (m['spot_count'] as num?)?.toInt() ?? 0,
        heroImageUrl: m['hero_image_url'] as String? ?? '',
        themeTags: ((m['theme_tags'] as List<dynamic>?) ?? const [])
            .map((e) => e as String)
            .toList(growable: false),
      );
}
