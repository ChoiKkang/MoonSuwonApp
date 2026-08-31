import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dalbit_suwon/features/course/data/course_repository.dart'
    show CourseRepository;
import 'package:dalbit_suwon/features/course/data/models/course.dart'
    show CourseSummary, CourseDetail;
import 'package:dalbit_suwon/features/course/data/models/course_detail_dto.dart'
    show CourseDetailDto, CourseDetailQueryDto, CoursePlaceDto;
import 'package:dalbit_suwon/features/course/data/models/home_course_dto.dart'
    show HomeCourseDto, HomeCoursesQueryDto;
import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;

class CourseRepositorySupabase implements CourseRepository {
  const CourseRepositorySupabase(this._client);

  final SupabaseClient _client;

  @override
  Future<List<CourseSummary>> fetchCoursesAsync() async {
    const query = HomeCoursesQueryDto();
    final rows =
        await _client.rpc('get_home_courses', params: query.toJson())
            as List<dynamic>;

    return rows
        .map(
          (row) =>
              HomeCourseDto.fromJson(Map<String, dynamic>.from(row as Map)),
        )
        .map(
          (course) => CourseSummary(
            id: course.id,
            title: course.heroTitle,
            subtitle: course.subtitle,
            estimatedDurationMin: course.estimatedDurationMin,
            walkingDistanceKm: course.walkingDistanceKm,
            recommendedStartTime: course.recommendedStartTime,
            spotCount: course.spotCount,
            heroImageUrl: course.heroImageUrl,
            themeTags: course.themeTags,
            petReadyFlag: course.petReadyFlag,
          ),
        )
        .toList();
  }

  @override
  Future<CourseDetail> fetchCourseDetailAsync(String courseId) async {
    final query = CourseDetailQueryDto(courseId);
    final row = await _client.rpc('get_course_detail', params: query.toJson());
    if (row == null) {
      throw Exception('코스를 찾을 수 없습니다: $courseId');
    }
    final detail = CourseDetailDto.fromJson(
      Map<String, dynamic>.from(row as Map),
    );

    return CourseDetail(
      id: detail.id,
      title: detail.heroTitle,
      subtitle: detail.subtitle,
      description: detail.routeSummary ?? '',
      estimatedDurationMin: detail.estimatedDurationMin,
      walkingDistanceKm: detail.walkingDistanceKm,
      recommendedStartTime: detail.recommendedStartTime,
      heroImageUrl: detail.heroImageUrl,
      themeTags: detail.themeTags,
      spots: detail.places.map(_toSpot).toList(),
      petReadyFlag: detail.petReadyFlag,
    );
  }

  Spot _toSpot(CoursePlaceDto place) {
    return Spot(
      id: place.placeId,
      name: place.displayName,
      summary: _firstNonEmpty([
        place.shortStory,
        place.nightHighlight,
        place.photoTip,
      ]),
      imageUrl: place.heroImageUrl ?? '',
      lat: place.lat,
      lng: place.lng,
      missionRadiusM: place.missionRadiusM,
      missionPrompt: place.missionPrompt ?? '',
    );
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value;
    }
    return '';
  }
}
