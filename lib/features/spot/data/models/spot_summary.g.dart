// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotSummary _$SpotSummaryFromJson(Map<String, dynamic> json) => _SpotSummary(
  id: json['id'] as String,
  slug: json['slug'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  heroImageUrl: json['heroImageUrl'] as String,
  crowdLevel: json['crowdLevel'] as String?,
  distanceM: (json['distanceM'] as num?)?.toDouble(),
  reasonLabel: json['reasonLabel'] as String,
  recommendationScore: (json['recommendationScore'] as num).toDouble(),
  forecastStatus: json['forecastStatus'] as String,
);

Map<String, dynamic> _$SpotSummaryToJson(_SpotSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'category': instance.category,
      'heroImageUrl': instance.heroImageUrl,
      'crowdLevel': instance.crowdLevel,
      'distanceM': instance.distanceM,
      'reasonLabel': instance.reasonLabel,
      'recommendationScore': instance.recommendationScore,
      'forecastStatus': instance.forecastStatus,
    };
