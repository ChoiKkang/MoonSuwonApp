// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseSummary _$CourseSummaryFromJson(Map<String, dynamic> json) =>
    _CourseSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      estimatedDurationMin: (json['estimatedDurationMin'] as num).toInt(),
      walkingDistanceKm: (json['walkingDistanceKm'] as num).toDouble(),
      recommendedStartTime: json['recommendedStartTime'] as String,
      spotCount: (json['spotCount'] as num).toInt(),
      heroImageUrl: json['heroImageUrl'] as String,
      themeTags: (json['themeTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      petReadyFlag: json['petReadyFlag'] as bool? ?? false,
    );

Map<String, dynamic> _$CourseSummaryToJson(_CourseSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'estimatedDurationMin': instance.estimatedDurationMin,
      'walkingDistanceKm': instance.walkingDistanceKm,
      'recommendedStartTime': instance.recommendedStartTime,
      'spotCount': instance.spotCount,
      'heroImageUrl': instance.heroImageUrl,
      'themeTags': instance.themeTags,
      'petReadyFlag': instance.petReadyFlag,
    };

_CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) =>
    _CourseDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      estimatedDurationMin: (json['estimatedDurationMin'] as num).toInt(),
      walkingDistanceKm: (json['walkingDistanceKm'] as num).toDouble(),
      recommendedStartTime: json['recommendedStartTime'] as String,
      heroImageUrl: json['heroImageUrl'] as String,
      themeTags: (json['themeTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spots: (json['spots'] as List<dynamic>)
          .map((e) => Spot.fromJson(e as Map<String, dynamic>))
          .toList(),
      petReadyFlag: json['petReadyFlag'] as bool? ?? false,
    );

Map<String, dynamic> _$CourseDetailToJson(_CourseDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'estimatedDurationMin': instance.estimatedDurationMin,
      'walkingDistanceKm': instance.walkingDistanceKm,
      'recommendedStartTime': instance.recommendedStartTime,
      'heroImageUrl': instance.heroImageUrl,
      'themeTags': instance.themeTags,
      'spots': instance.spots,
      'petReadyFlag': instance.petReadyFlag,
    };
