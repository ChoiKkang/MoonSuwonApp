import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/course_repository_supabase.dart'
    show CourseRepositorySupabase;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary, CourseDetail;

part 'course_provider.g.dart';

@riverpod
CourseRepository courseRepository(Ref ref) =>
    CourseRepositorySupabase(Supabase.instance.client);

@riverpod
Future<List<CourseSummary>> courses(Ref ref) =>
    ref.read(courseRepositoryProvider).fetchCoursesAsync();

@riverpod
Future<CourseDetail> courseDetail(Ref ref, String courseId) =>
    ref.read(courseRepositoryProvider).fetchCourseDetailAsync(courseId);
