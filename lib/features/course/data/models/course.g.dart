// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseSummaryImpl _$$CourseSummaryImplFromJson(Map<String, dynamic> json) =>
    _$CourseSummaryImpl(
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

Map<String, dynamic> _$$CourseSummaryImplToJson(_$CourseSummaryImpl instance) =>
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

_$CourseDetailImpl _$$CourseDetailImplFromJson(Map<String, dynamic> json) =>
    _$CourseDetailImpl(
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

Map<String, dynamic> _$$CourseDetailImplToJson(_$CourseDetailImpl instance) =>
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
