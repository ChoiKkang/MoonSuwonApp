import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dalbit_suwon/features/course/data/models/spot.dart' show Spot;

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
abstract class CourseSummary with _$CourseSummary {
  const factory CourseSummary({
    required String id,
    required String title,
    required String subtitle,
    required int estimatedDurationMin,
    required double walkingDistanceKm,
    required String recommendedStartTime,
    required int spotCount,
    required String heroImageUrl,
    required List<String> themeTags,
    @Default(false) bool petReadyFlag,
  }) = _CourseSummary;

  factory CourseSummary.fromJson(Map<String, dynamic> json) =>
      _$CourseSummaryFromJson(json);
}

@freezed
abstract class CourseDetail with _$CourseDetail {
  const factory CourseDetail({
    required String id,
    required String title,
    required String subtitle,
    required String description,
    required int estimatedDurationMin,
    required double walkingDistanceKm,
    required String recommendedStartTime,
    required String heroImageUrl,
    required List<String> themeTags,
    required List<Spot> spots,
    @Default(false) bool petReadyFlag,
  }) = _CourseDetail;

  factory CourseDetail.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailFromJson(json);
}
