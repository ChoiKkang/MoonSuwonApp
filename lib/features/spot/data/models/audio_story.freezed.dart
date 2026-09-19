// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioStory {

 String get id; String? get spotTitle; String get audioTitle; String? get script; int? get playSeconds; String? get audioUrl; int? get distanceM;
/// Create a copy of AudioStory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStoryCopyWith<AudioStory> get copyWith => _$AudioStoryCopyWithImpl<AudioStory>(this as AudioStory, _$identity);

  /// Serializes this AudioStory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioStory&&(identical(other.id, id) || other.id == id)&&(identical(other.spotTitle, spotTitle) || other.spotTitle == spotTitle)&&(identical(other.audioTitle, audioTitle) || other.audioTitle == audioTitle)&&(identical(other.script, script) || other.script == script)&&(identical(other.playSeconds, playSeconds) || other.playSeconds == playSeconds)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotTitle,audioTitle,script,playSeconds,audioUrl,distanceM);

@override
String toString() {
  return 'AudioStory(id: $id, spotTitle: $spotTitle, audioTitle: $audioTitle, script: $script, playSeconds: $playSeconds, audioUrl: $audioUrl, distanceM: $distanceM)';
}


}

/// @nodoc
abstract mixin class $AudioStoryCopyWith<$Res>  {
  factory $AudioStoryCopyWith(AudioStory value, $Res Function(AudioStory) _then) = _$AudioStoryCopyWithImpl;
@useResult
$Res call({
 String id, String? spotTitle, String audioTitle, String? script, int? playSeconds, String? audioUrl, int? distanceM
});




}
/// @nodoc
class _$AudioStoryCopyWithImpl<$Res>
    implements $AudioStoryCopyWith<$Res> {
  _$AudioStoryCopyWithImpl(this._self, this._then);

  final AudioStory _self;
  final $Res Function(AudioStory) _then;

/// Create a copy of AudioStory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotTitle = freezed,Object? audioTitle = null,Object? script = freezed,Object? playSeconds = freezed,Object? audioUrl = freezed,Object? distanceM = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spotTitle: freezed == spotTitle ? _self.spotTitle : spotTitle // ignore: cast_nullable_to_non_nullable
as String?,audioTitle: null == audioTitle ? _self.audioTitle : audioTitle // ignore: cast_nullable_to_non_nullable
as String,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,playSeconds: freezed == playSeconds ? _self.playSeconds : playSeconds // ignore: cast_nullable_to_non_nullable
as int?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioStory].
extension AudioStoryPatterns on AudioStory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioStory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioStory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioStory value)  $default,){
final _that = this;
switch (_that) {
case _AudioStory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioStory value)?  $default,){
final _that = this;
switch (_that) {
case _AudioStory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? spotTitle,  String audioTitle,  String? script,  int? playSeconds,  String? audioUrl,  int? distanceM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioStory() when $default != null:
return $default(_that.id,_that.spotTitle,_that.audioTitle,_that.script,_that.playSeconds,_that.audioUrl,_that.distanceM);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? spotTitle,  String audioTitle,  String? script,  int? playSeconds,  String? audioUrl,  int? distanceM)  $default,) {final _that = this;
switch (_that) {
case _AudioStory():
return $default(_that.id,_that.spotTitle,_that.audioTitle,_that.script,_that.playSeconds,_that.audioUrl,_that.distanceM);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? spotTitle,  String audioTitle,  String? script,  int? playSeconds,  String? audioUrl,  int? distanceM)?  $default,) {final _that = this;
switch (_that) {
case _AudioStory() when $default != null:
return $default(_that.id,_that.spotTitle,_that.audioTitle,_that.script,_that.playSeconds,_that.audioUrl,_that.distanceM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AudioStory extends AudioStory {
  const _AudioStory({required this.id, this.spotTitle, required this.audioTitle, this.script, this.playSeconds, this.audioUrl, this.distanceM}): super._();
  factory _AudioStory.fromJson(Map<String, dynamic> json) => _$AudioStoryFromJson(json);

@override final  String id;
@override final  String? spotTitle;
@override final  String audioTitle;
@override final  String? script;
@override final  int? playSeconds;
@override final  String? audioUrl;
@override final  int? distanceM;

/// Create a copy of AudioStory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioStoryCopyWith<_AudioStory> get copyWith => __$AudioStoryCopyWithImpl<_AudioStory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioStoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioStory&&(identical(other.id, id) || other.id == id)&&(identical(other.spotTitle, spotTitle) || other.spotTitle == spotTitle)&&(identical(other.audioTitle, audioTitle) || other.audioTitle == audioTitle)&&(identical(other.script, script) || other.script == script)&&(identical(other.playSeconds, playSeconds) || other.playSeconds == playSeconds)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotTitle,audioTitle,script,playSeconds,audioUrl,distanceM);

@override
String toString() {
  return 'AudioStory(id: $id, spotTitle: $spotTitle, audioTitle: $audioTitle, script: $script, playSeconds: $playSeconds, audioUrl: $audioUrl, distanceM: $distanceM)';
}


}

/// @nodoc
abstract mixin class _$AudioStoryCopyWith<$Res> implements $AudioStoryCopyWith<$Res> {
  factory _$AudioStoryCopyWith(_AudioStory value, $Res Function(_AudioStory) _then) = __$AudioStoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String? spotTitle, String audioTitle, String? script, int? playSeconds, String? audioUrl, int? distanceM
});




}
/// @nodoc
class __$AudioStoryCopyWithImpl<$Res>
    implements _$AudioStoryCopyWith<$Res> {
  __$AudioStoryCopyWithImpl(this._self, this._then);

  final _AudioStory _self;
  final $Res Function(_AudioStory) _then;

/// Create a copy of AudioStory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotTitle = freezed,Object? audioTitle = null,Object? script = freezed,Object? playSeconds = freezed,Object? audioUrl = freezed,Object? distanceM = freezed,}) {
  return _then(_AudioStory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,spotTitle: freezed == spotTitle ? _self.spotTitle : spotTitle // ignore: cast_nullable_to_non_nullable
as String?,audioTitle: null == audioTitle ? _self.audioTitle : audioTitle // ignore: cast_nullable_to_non_nullable
as String,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,playSeconds: freezed == playSeconds ? _self.playSeconds : playSeconds // ignore: cast_nullable_to_non_nullable
as int?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
