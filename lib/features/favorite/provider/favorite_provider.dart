import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository_local.dart'
    show FavoriteRepositoryLocal;
import 'package:dalbit_suwon/features/favorite/data/favorite_repository_supabase.dart'
    show FavoriteRepositorySupabase;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;

/// 게스트 상태에서 사용하는 로컬 저장소 (SharedPreferences).
final favoriteRepositoryLocalProvider = Provider<FavoriteRepositoryLocal>(
  (ref) => FavoriteRepositoryLocal(),
);

/// 로그인 상태에서 사용하는 서버 저장소 (Supabase RPC).
final favoriteRepositorySupabaseProvider = Provider<FavoriteRepositorySupabase>(
  (ref) => FavoriteRepositorySupabase(Supabase.instance.client),
);

/// 로그인 상태에 따라 로컬/서버 저장소 중 하나를 반환.
///
/// 로그인/로그아웃 시 자동으로 다른 저장소로 스위치되고,
/// 이 provider를 watch하는 하위 FutureProvider들은 자동으로 재빌드된다.
final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final isLoggedIn = ref.watch(authNotifierProvider);
  return isLoggedIn
      ? ref.watch(favoriteRepositorySupabaseProvider)
      : ref.watch(favoriteRepositoryLocalProvider);
});

/// 현재 찜한 스팟 목록.
final favoriteSpotsProvider = FutureProvider<List<FavoriteSpotSummary>>((
  ref,
) async {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.fetchFavoriteSpotsAsync();
});

/// 현재 찜한 코스 목록.
final favoriteCoursesProvider = FutureProvider<List<FavoriteCourseSummary>>((
  ref,
) async {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.fetchFavoriteCoursesAsync();
});

/// 스팟/코스 상세 페이지의 토글 버튼이 현재 찜 여부를 판단하기 위한 집합.
///
/// 두 하위 provider(spots, courses)의 로딩/에러 상태를 합쳐 하나의 AsyncValue로 노출한다.
final favoriteTargetsProvider = Provider<AsyncValue<Set<FavoriteTarget>>>((
  ref,
) {
  final spotsAsync = ref.watch(favoriteSpotsProvider);
  final coursesAsync = ref.watch(favoriteCoursesProvider);

  if (spotsAsync.isLoading || coursesAsync.isLoading) {
    return const AsyncValue.loading();
  }
  final error = spotsAsync.error ?? coursesAsync.error;
  if (error != null) {
    final stack = spotsAsync.stackTrace ?? coursesAsync.stackTrace ??
        StackTrace.current;
    return AsyncValue.error(error, stack);
  }
  final targets = <FavoriteTarget>{
    for (final s in spotsAsync.value ?? const <FavoriteSpotSummary>[])
      FavoriteTarget(type: FavoriteTargetType.spot, id: s.placeId),
    for (final c in coursesAsync.value ?? const <FavoriteCourseSummary>[])
      FavoriteTarget(type: FavoriteTargetType.course, id: c.courseId),
  };
  return AsyncValue.data(targets);
});
