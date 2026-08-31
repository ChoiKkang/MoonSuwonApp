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

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authNotifierProvider, (previous, next) => notifyListeners());
  }
  final Ref _ref;
}

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
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthLoginPage(),
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
      GoRoute(path: '/mypage', builder: (context, state) => const MyPagePage()),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const ProfileEditPage(),
      ),
      GoRoute(
        path: '/nearby',
        builder: (context, state) => const NearbyPage(),
      ),
      GoRoute(
        path: '/bookmarks',
        builder: (context, state) => const FavoritePage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('페이지를 찾을 수 없습니다: ${state.error}'))),
  );
});
