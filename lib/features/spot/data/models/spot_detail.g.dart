// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalSpot _$LocalSpotFromJson(Map<String, dynamic> json) => _LocalSpot(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  summary: json['summary'] as String,
  imageUrl: json['imageUrl'] as String,
  walkingMinutes: (json['walkingMinutes'] as num).toInt(),
  petFriendly: json['petFriendly'] as bool? ?? false,
);

Map<String, dynamic> _$LocalSpotToJson(_LocalSpot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
      'walkingMinutes': instance.walkingMinutes,
      'petFriendly': instance.petFriendly,
    };

_SpotDetail _$SpotDetailFromJson(Map<String, dynamic> json) => _SpotDetail(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  intro: json['intro'] as String,
  heroImageUrl: json['heroImageUrl'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  nightHighlight: json['nightHighlight'] as String,
  photoTip: json['photoTip'] as String,
  romanticMoment: json['romanticMoment'] as String,
  missionPrompt: json['missionPrompt'] as String,
  missionRadiusM: (json['missionRadiusM'] as num).toInt(),
  nearbySpots: (json['nearbySpots'] as List<dynamic>)
      .map((e) => LocalSpot.fromJson(e as Map<String, dynamic>))
      .toList(),
  petPolicy: json['petPolicy'] as String? ?? 'partial',
  petNote: json['petNote'] as String? ?? '',
);

Map<String, dynamic> _$SpotDetailToJson(_SpotDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'intro': instance.intro,
      'heroImageUrl': instance.heroImageUrl,
      'lat': instance.lat,
      'lng': instance.lng,
      'nightHighlight': instance.nightHighlight,
      'photoTip': instance.photoTip,
      'romanticMoment': instance.romanticMoment,
      'missionPrompt': instance.missionPrompt,
      'missionRadiusM': instance.missionRadiusM,
      'nearbySpots': instance.nearbySpots,
      'petPolicy': instance.petPolicy,
      'petNote': instance.petNote,
    };
