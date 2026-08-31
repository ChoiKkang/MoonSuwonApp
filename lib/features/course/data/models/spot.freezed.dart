// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Spot {

 String get id; String get name; String get summary; String get imageUrl; double get lat; double get lng; int get missionRadiusM; String get missionPrompt; SpotProgressStatus get status; String get petPolicy; String get petNote;
/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotCopyWith<Spot> get copyWith => _$SpotCopyWithImpl<Spot>(this as Spot, _$identity);

  /// Serializes this Spot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Spot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.missionRadiusM, missionRadiusM) || other.missionRadiusM == missionRadiusM)&&(identical(other.missionPrompt, missionPrompt) || other.missionPrompt == missionPrompt)&&(identical(other.status, status) || other.status == status)&&(identical(other.petPolicy, petPolicy) || other.petPolicy == petPolicy)&&(identical(other.petNote, petNote) || other.petNote == petNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,summary,imageUrl,lat,lng,missionRadiusM,missionPrompt,status,petPolicy,petNote);

@override
String toString() {
  return 'Spot(id: $id, name: $name, summary: $summary, imageUrl: $imageUrl, lat: $lat, lng: $lng, missionRadiusM: $missionRadiusM, missionPrompt: $missionPrompt, status: $status, petPolicy: $petPolicy, petNote: $petNote)';
}


}

/// @nodoc
abstract mixin class $SpotCopyWith<$Res>  {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) _then) = _$SpotCopyWithImpl;
@useResult
$Res call({
 String id, String name, String summary, String imageUrl, double lat, double lng, int missionRadiusM, String missionPrompt, SpotProgressStatus status, String petPolicy, String petNote
});




}
/// @nodoc
class _$SpotCopyWithImpl<$Res>
    implements $SpotCopyWith<$Res> {
  _$SpotCopyWithImpl(this._self, this._then);

  final Spot _self;
  final $Res Function(Spot) _then;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? summary = null,Object? imageUrl = null,Object? lat = null,Object? lng = null,Object? missionRadiusM = null,Object? missionPrompt = null,Object? status = null,Object? petPolicy = null,Object? petNote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,missionRadiusM: null == missionRadiusM ? _self.missionRadiusM : missionRadiusM // ignore: cast_nullable_to_non_nullable
as int,missionPrompt: null == missionPrompt ? _self.missionPrompt : missionPrompt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpotProgressStatus,petPolicy: null == petPolicy ? _self.petPolicy : petPolicy // ignore: cast_nullable_to_non_nullable
as String,petNote: null == petNote ? _self.petNote : petNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Spot].
extension SpotPatterns on Spot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Spot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Spot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Spot value)  $default,){
final _that = this;
switch (_that) {
case _Spot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Spot value)?  $default,){
final _that = this;
switch (_that) {
case _Spot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String summary,  String imageUrl,  double lat,  double lng,  int missionRadiusM,  String missionPrompt,  SpotProgressStatus status,  String petPolicy,  String petNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.id,_that.name,_that.summary,_that.imageUrl,_that.lat,_that.lng,_that.missionRadiusM,_that.missionPrompt,_that.status,_that.petPolicy,_that.petNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String summary,  String imageUrl,  double lat,  double lng,  int missionRadiusM,  String missionPrompt,  SpotProgressStatus status,  String petPolicy,  String petNote)  $default,) {final _that = this;
switch (_that) {
case _Spot():
return $default(_that.id,_that.name,_that.summary,_that.imageUrl,_that.lat,_that.lng,_that.missionRadiusM,_that.missionPrompt,_that.status,_that.petPolicy,_that.petNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String summary,  String imageUrl,  double lat,  double lng,  int missionRadiusM,  String missionPrompt,  SpotProgressStatus status,  String petPolicy,  String petNote)?  $default,) {final _that = this;
switch (_that) {
case _Spot() when $default != null:
return $default(_that.id,_that.name,_that.summary,_that.imageUrl,_that.lat,_that.lng,_that.missionRadiusM,_that.missionPrompt,_that.status,_that.petPolicy,_that.petNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Spot implements Spot {
  const _Spot({required this.id, required this.name, required this.summary, required this.imageUrl, required this.lat, required this.lng, required this.missionRadiusM, required this.missionPrompt, this.status = SpotProgressStatus.pending, this.petPolicy = 'partial', this.petNote = ''});
  factory _Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

@override final  String id;
@override final  String name;
@override final  String summary;
@override final  String imageUrl;
@override final  double lat;
@override final  double lng;
@override final  int missionRadiusM;
@override final  String missionPrompt;
@override@JsonKey() final  SpotProgressStatus status;
@override@JsonKey() final  String petPolicy;
@override@JsonKey() final  String petNote;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotCopyWith<_Spot> get copyWith => __$SpotCopyWithImpl<_Spot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Spot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.missionRadiusM, missionRadiusM) || other.missionRadiusM == missionRadiusM)&&(identical(other.missionPrompt, missionPrompt) || other.missionPrompt == missionPrompt)&&(identical(other.status, status) || other.status == status)&&(identical(other.petPolicy, petPolicy) || other.petPolicy == petPolicy)&&(identical(other.petNote, petNote) || other.petNote == petNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,summary,imageUrl,lat,lng,missionRadiusM,missionPrompt,status,petPolicy,petNote);

@override
String toString() {
  return 'Spot(id: $id, name: $name, summary: $summary, imageUrl: $imageUrl, lat: $lat, lng: $lng, missionRadiusM: $missionRadiusM, missionPrompt: $missionPrompt, status: $status, petPolicy: $petPolicy, petNote: $petNote)';
}


}

/// @nodoc
abstract mixin class _$SpotCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$SpotCopyWith(_Spot value, $Res Function(_Spot) _then) = __$SpotCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String summary, String imageUrl, double lat, double lng, int missionRadiusM, String missionPrompt, SpotProgressStatus status, String petPolicy, String petNote
});




}
/// @nodoc
class __$SpotCopyWithImpl<$Res>
    implements _$SpotCopyWith<$Res> {
  __$SpotCopyWithImpl(this._self, this._then);

  final _Spot _self;
  final $Res Function(_Spot) _then;

/// Create a copy of Spot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? summary = null,Object? imageUrl = null,Object? lat = null,Object? lng = null,Object? missionRadiusM = null,Object? missionPrompt = null,Object? status = null,Object? petPolicy = null,Object? petNote = null,}) {
  return _then(_Spot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,missionRadiusM: null == missionRadiusM ? _self.missionRadiusM : missionRadiusM // ignore: cast_nullable_to_non_nullable
as int,missionPrompt: null == missionPrompt ? _self.missionPrompt : missionPrompt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpotProgressStatus,petPolicy: null == petPolicy ? _self.petPolicy : petPolicy // ignore: cast_nullable_to_non_nullable
as String,petNote: null == petNote ? _self.petNote : petNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
