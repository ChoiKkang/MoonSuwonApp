import 'package:dalbit_suwon/features/course/data/models/course.dart' show CourseSummary, CourseDetail;

abstract class CourseRepository {
  Future<List<CourseSummary>> fetchCoursesAsync();
  Future<CourseDetail> fetchCourseDetailAsync(String courseId);
}
