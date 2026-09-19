// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowd_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyCrowd _$DailyCrowdFromJson(Map<String, dynamic> json) => _DailyCrowd(
  date: json['date'] as String,
  level: json['level'] as String? ?? 'unknown',
  score: (json['score'] as num?)?.toDouble(),
  dataStatus: json['dataStatus'] as String? ?? 'unknown',
);

Map<String, dynamic> _$DailyCrowdToJson(_DailyCrowd instance) =>
    <String, dynamic>{
      'date': instance.date,
      'level': instance.level,
      'score': instance.score,
      'dataStatus': instance.dataStatus,
    };

_CrowdForecast _$CrowdForecastFromJson(Map<String, dynamic> json) =>
    _CrowdForecast(
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => DailyCrowd.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DailyCrowd>[],
    );

Map<String, dynamic> _$CrowdForecastToJson(_CrowdForecast instance) =>
    <String, dynamic>{'days': instance.days};
