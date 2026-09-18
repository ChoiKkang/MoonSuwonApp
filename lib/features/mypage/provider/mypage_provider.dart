import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/course/provider/course_provider.dart'
    show courseRepositoryProvider;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart'
    show MyPageSummary;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository.dart'
    show MyPageRepository;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository_supabase.dart'
    show MyPageRepositorySupabase;

part 'mypage_provider.g.dart';

/// 마이페이지 Repository provider.
///
/// 실제 Supabase 구현체를 주입한다. `CourseRepository`는 `courseRepositoryProvider`
/// 를 통해 얻어 `list_user_course_history` RPC를 호출한다.
@riverpod
MyPageRepository myPageRepository(Ref ref) {
  final courseRepository = ref.watch(courseRepositoryProvider);
  return MyPageRepositorySupabase(courseRepository);
}

/// 마이페이지 요약 정보(최근 진행 코스 등).
///
/// 인증 상태([authNotifierProvider])를 watch하여 로그인/로그아웃 시점에
/// 자동으로 재조회한다. 로그아웃 상태에서는 서버 RPC가 빈 결과를 반환하므로
/// `recentCourse == null` 상태가 되어 카드는 화면에 표시되지 않는다.
@riverpod
Future<MyPageSummary> myPageSummary(Ref ref) {
  // 로그인 상태가 변하면 최근 진행 코스도 함께 재조회한다.
  ref.watch(authNotifierProvider);
  return ref.read(myPageRepositoryProvider).fetchSummaryAsync();
}
