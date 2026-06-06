import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/course/data/course_repository.dart' show CourseRepository;
import 'package:dalbit_suwon/features/course/data/course_repository_mock.dart' show CourseRepositoryMock;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary, CourseDetail;

part 'course_provider.g.dart';

@riverpod
CourseRepository courseRepository(Ref ref) => CourseRepositoryMock();

@riverpod
Future<List<CourseSummary>> courses(Ref ref) =>
    ref.read(courseRepositoryProvider).fetchCoursesAsync();

@riverpod
Future<CourseDetail> courseDetail(Ref ref, String courseId) =>
    ref.read(courseRepositoryProvider).fetchCourseDetailAsync(courseId);
