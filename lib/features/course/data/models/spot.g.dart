// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotImpl _$$SpotImplFromJson(Map<String, dynamic> json) => _$SpotImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  summary: json['summary'] as String,
  imageUrl: json['imageUrl'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  missionRadiusM: (json['missionRadiusM'] as num).toInt(),
  missionPrompt: json['missionPrompt'] as String,
  status:
      $enumDecodeNullable(_$SpotProgressStatusEnumMap, json['status']) ??
      SpotProgressStatus.pending,
  petPolicy: json['petPolicy'] as String? ?? 'partial',
  petNote: json['petNote'] as String? ?? '',
);

Map<String, dynamic> _$$SpotImplToJson(_$SpotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
      'lat': instance.lat,
      'lng': instance.lng,
      'missionRadiusM': instance.missionRadiusM,
      'missionPrompt': instance.missionPrompt,
      'status': _$SpotProgressStatusEnumMap[instance.status]!,
      'petPolicy': instance.petPolicy,
      'petNote': instance.petNote,
    };

const _$SpotProgressStatusEnumMap = {
  SpotProgressStatus.pending: 'pending',
  SpotProgressStatus.current: 'current',
  SpotProgressStatus.completed: 'completed',
};
