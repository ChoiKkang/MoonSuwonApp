/// `public.upsert_favorite` / `public.remove_favorite` RPC 요청 파라미터 DTO.
class FavoriteMutationDto {
  const FavoriteMutationDto({
    required this.targetType,
    required this.targetId,
  });

  /// `'course'` 또는 `'spot'` (Supabase 함수 CHECK 제약 준수).
  final String targetType;

  /// 코스면 `core.courses.id`, 스팟이면 `core.places.id`.
  final String targetId;

  Map<String, dynamic> toJson() => {
    'p_target_type': targetType,
    'p_target_id': targetId,
  };
}
