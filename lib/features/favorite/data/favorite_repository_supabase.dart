import 'package:supabase_flutter/supabase_flutter.dart' show SupabaseClient;

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget, FavoriteTargetTypeCode;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_dto.dart'
    show FavoriteCourseDto;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_mutation_dto.dart'
    show FavoriteMutationDto;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_dto.dart'
    show FavoriteSpotDto;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

/// 로그인 사용자의 찜을 `public.list_favorite_*` / `public.upsert_favorite` /
/// `public.remove_favorite` RPC로 관리한다.
///
/// RPC 내부에서 auth.uid()로 본인 데이터만 접근하고, `core.user_favorites`의
/// RLS `favorites_own_or_admin` 정책이 이중 방어를 제공한다.
class FavoriteRepositorySupabase implements FavoriteRepository {
  const FavoriteRepositorySupabase(this._client);

  final SupabaseClient _client;

  @override
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync() async {
    final rows =
        await _client.rpc('list_favorite_spots') as List<dynamic>;
    return rows
        .map(
          (row) =>
              FavoriteSpotDto.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .map(
          (dto) => FavoriteSpotSummary(
            placeId: dto.placeId,
            slug: dto.placeSlug,
            name: dto.displayName,
            category: dto.category,
            heroImageUrl: dto.heroImageUrl,
            nightHighlight: dto.nightHighlight,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync() async {
    final rows =
        await _client.rpc('list_favorite_courses') as List<dynamic>;
    return rows
        .map(
          (row) =>
              FavoriteCourseDto.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .map(
          (dto) => FavoriteCourseSummary(
            courseId: dto.courseId,
            slug: dto.courseSlug,
            title: dto.heroTitle,
            subtitle: dto.subtitle,
            routeSummary: dto.routeSummary,
            estimatedDurationMin: dto.estimatedDurationMin,
            spotCount: dto.spotCount,
            heroImageUrl: dto.heroImageUrl,
            themeTags: dto.themeTags,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> addSpotAsync(FavoriteSpotSummary spot) async {
    final dto = FavoriteMutationDto(
      targetType: 'spot',
      targetId: spot.placeId,
    );
    await _client.rpc('upsert_favorite', params: dto.toJson());
  }

  @override
  Future<void> addCourseAsync(FavoriteCourseSummary course) async {
    final dto = FavoriteMutationDto(
      targetType: 'course',
      targetId: course.courseId,
    );
    await _client.rpc('upsert_favorite', params: dto.toJson());
  }

  @override
  Future<void> removeAsync(FavoriteTarget target) async {
    final dto = FavoriteMutationDto(
      targetType: target.type.code,
      targetId: target.id,
    );
    await _client.rpc('remove_favorite', params: dto.toJson());
  }
}
