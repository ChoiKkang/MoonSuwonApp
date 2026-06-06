import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:dalbit_suwon/features/home/ui/home_page.dart' show HomePage;
import 'package:dalbit_suwon/features/course/ui/course_detail_page.dart' show CourseDetailPage;
import 'package:dalbit_suwon/features/course/ui/course_progress_page.dart' show CourseProgressPage;
import 'package:dalbit_suwon/features/course/ui/course_complete_page.dart' show CourseCompletePage;
import 'package:dalbit_suwon/features/spot/ui/spot_detail_page.dart' show SpotDetailPage;
import 'package:dalbit_suwon/features/auth/ui/auth_login_page.dart' show AuthLoginPage;

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const AuthLoginPage(),
    ),
    GoRoute(
      path: '/course/:id',
      builder: (context, state) => CourseDetailPage(
        courseId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/course/:id/progress',
      builder: (context, state) => CourseProgressPage(
        courseId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/course/:id/complete',
      builder: (context, state) => CourseCompletePage(
        courseId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/spot/:id',
      builder: (context, state) => SpotDetailPage(
        spotId: state.pathParameters['id']!,
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
    ),
  ),
);
