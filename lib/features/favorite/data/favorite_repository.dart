import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

/// 찜 대상의 종류를 구분한다.
enum FavoriteTargetType { course, spot }

extension FavoriteTargetTypeCode on FavoriteTargetType {
  /// Supabase RPC의 `p_target_type`으로 전달되는 문자열 코드.
  String get code => switch (this) {
    FavoriteTargetType.course => 'course',
    FavoriteTargetType.spot => 'spot',
  };
}

/// 로컬/서버 저장소가 공통으로 다루는 찜 대상 식별자.
class FavoriteTarget {
  const FavoriteTarget({required this.type, required this.id});

  final FavoriteTargetType type;

  /// 코스면 `core.courses.id`, 스팟이면 `core.places.id` (uuid 또는 mock id).
  final String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteTarget && other.type == type && other.id == id;

  @override
  int get hashCode => Object.hash(type, id);

  @override
  String toString() => 'FavoriteTarget(${type.code}:$id)';
}

/// 찜(즐겨찾기) 저장소 공통 인터페이스.
///
/// - 게스트 상태에서는 `FavoriteRepositoryLocal`이 SharedPreferences로 캐시.
/// - 로그인 상태에서는 `FavoriteRepositorySupabase`가 `core.user_favorites`를
///   래핑한 `public.list_favorite_*` / `public.upsert_favorite` /
///   `public.remove_favorite` RPC로 서버와 통신.
abstract class FavoriteRepository {
  /// 현재 저장된 찜 스팟 목록 (카드 표시에 필요한 요약).
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync();

  /// 현재 저장된 찜 코스 목록.
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync();

  /// 스팟 찜 추가 (idempotent).
  Future<void> addSpotAsync(FavoriteSpotSummary spot);

  /// 코스 찜 추가 (idempotent).
  Future<void> addCourseAsync(FavoriteCourseSummary course);

  /// 찜 삭제 (idempotent). 존재하지 않는 대상이어도 예외를 던지지 않는다.
  Future<void> removeAsync(FavoriteTarget target);
}
