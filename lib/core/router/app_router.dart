import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/auth/provider/auth_provider.dart'
    show authNotifierProvider;
import 'package:dalbit_suwon/features/favorite/ui/favorite_page.dart'
    show FavoritePage;
import 'package:dalbit_suwon/features/home/ui/home_page.dart' show HomePage;
import 'package:dalbit_suwon/features/course/ui/course_detail_page.dart'
    show CourseDetailPage;
import 'package:dalbit_suwon/features/course/ui/course_progress_page.dart'
    show CourseProgressPage;
import 'package:dalbit_suwon/features/course/ui/course_complete_page.dart'
    show CourseCompletePage;
import 'package:dalbit_suwon/features/course/ui/courses_list_page.dart'
    show CoursesListPage;
import 'package:dalbit_suwon/features/nearby/ui/nearby_page.dart'
    show NearbyPage;
import 'package:dalbit_suwon/features/spot/ui/spot_detail_page.dart'
    show SpotDetailPage;
import 'package:dalbit_suwon/features/auth/ui/auth_login_page.dart'
    show AuthLoginPage;
import 'package:dalbit_suwon/features/auth/ui/profile_edit_page.dart'
    show ProfileEditPage;
import 'package:dalbit_suwon/features/mypage/ui/mypage_page.dart'
    show MyPagePage;
import 'package:dalbit_suwon/features/mypage/ui/course_history_page.dart'
    show CourseHistoryPage;

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authNotifierProvider, (previous, next) => notifyListeners());
  }
  final Ref _ref;
}

/// 앱 전역 라우터.
///
/// 페이지 전환 정책:
/// - GNB(하단 탭) 목적지(`/`, `/nearby`, `/bookmarks`, `/mypage`)는
///   [NoTransitionPage]를 사용해 탭 전환 시 애니메이션 없이 즉시 화면을 교체한다.
/// - 2depth 화면(코스 상세/진행/완료, 스팟 상세, 코스 리스트, 프로필 편집, 로그인 등)은
///   `builder`를 통해 플랫폼 기본 `MaterialPage`를 그대로 사용하며
///   iOS 슬라이드 / Android push 애니메이션이 적용된다.
final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authNotifierProvider);
      final isLoginPage = state.matchedLocation == '/login';
      if (isLoggedIn && isLoginPage) return '/';
      return null;
    },
    routes: [
      // ── GNB 목적지 (탭 전환 애니메이션 제거) ──────────────────────────
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/nearby',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: NearbyPage()),
      ),
      GoRoute(
        path: '/bookmarks',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: FavoritePage()),
      ),
      GoRoute(
        path: '/mypage',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: MyPagePage()),
      ),

      // ── 2depth 화면 (플랫폼 기본 push 애니메이션 유지) ────────────────
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthLoginPage(),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CoursesListPage(),
      ),
      GoRoute(
        path: '/course/:id',
        builder: (context, state) =>
            CourseDetailPage(courseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/course/:id/progress',
        builder: (context, state) =>
            CourseProgressPage(courseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/course/:id/complete',
        builder: (context, state) =>
            CourseCompletePage(courseId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/spot/:id',
        builder: (context, state) =>
            SpotDetailPage(spotId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const ProfileEditPage(),
      ),
      GoRoute(
        path: '/mypage/history',
        builder: (context, state) => const CourseHistoryPage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('페이지를 찾을 수 없습니다: ${state.error}'))),
  );
});
