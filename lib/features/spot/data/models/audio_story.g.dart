// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioStory _$AudioStoryFromJson(Map<String, dynamic> json) => _AudioStory(
  id: json['id'] as String,
  spotTitle: json['spotTitle'] as String?,
  audioTitle: json['audioTitle'] as String,
  script: json['script'] as String?,
  playSeconds: (json['playSeconds'] as num?)?.toInt(),
  audioUrl: json['audioUrl'] as String?,
  distanceM: (json['distanceM'] as num?)?.toInt(),
);

Map<String, dynamic> _$AudioStoryToJson(_AudioStory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spotTitle': instance.spotTitle,
      'audioTitle': instance.audioTitle,
      'script': instance.script,
      'playSeconds': instance.playSeconds,
      'audioUrl': instance.audioUrl,
      'distanceM': instance.distanceM,
    };
