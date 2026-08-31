// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalSpot {

 String get id; String get name; String get type; String get summary; String get imageUrl; int get walkingMinutes; bool get petFriendly;
/// Create a copy of LocalSpot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalSpotCopyWith<LocalSpot> get copyWith => _$LocalSpotCopyWithImpl<LocalSpot>(this as LocalSpot, _$identity);

  /// Serializes this LocalSpot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.walkingMinutes, walkingMinutes) || other.walkingMinutes == walkingMinutes)&&(identical(other.petFriendly, petFriendly) || other.petFriendly == petFriendly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,summary,imageUrl,walkingMinutes,petFriendly);

@override
String toString() {
  return 'LocalSpot(id: $id, name: $name, type: $type, summary: $summary, imageUrl: $imageUrl, walkingMinutes: $walkingMinutes, petFriendly: $petFriendly)';
}


}

/// @nodoc
abstract mixin class $LocalSpotCopyWith<$Res>  {
  factory $LocalSpotCopyWith(LocalSpot value, $Res Function(LocalSpot) _then) = _$LocalSpotCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String summary, String imageUrl, int walkingMinutes, bool petFriendly
});




}
/// @nodoc
class _$LocalSpotCopyWithImpl<$Res>
    implements $LocalSpotCopyWith<$Res> {
  _$LocalSpotCopyWithImpl(this._self, this._then);

  final LocalSpot _self;
  final $Res Function(LocalSpot) _then;

/// Create a copy of LocalSpot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? summary = null,Object? imageUrl = null,Object? walkingMinutes = null,Object? petFriendly = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,walkingMinutes: null == walkingMinutes ? _self.walkingMinutes : walkingMinutes // ignore: cast_nullable_to_non_nullable
as int,petFriendly: null == petFriendly ? _self.petFriendly : petFriendly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalSpot].
extension LocalSpotPatterns on LocalSpot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalSpot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalSpot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalSpot value)  $default,){
final _that = this;
switch (_that) {
case _LocalSpot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalSpot value)?  $default,){
final _that = this;
switch (_that) {
case _LocalSpot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String summary,  String imageUrl,  int walkingMinutes,  bool petFriendly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalSpot() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.summary,_that.imageUrl,_that.walkingMinutes,_that.petFriendly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String summary,  String imageUrl,  int walkingMinutes,  bool petFriendly)  $default,) {final _that = this;
switch (_that) {
case _LocalSpot():
return $default(_that.id,_that.name,_that.type,_that.summary,_that.imageUrl,_that.walkingMinutes,_that.petFriendly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String summary,  String imageUrl,  int walkingMinutes,  bool petFriendly)?  $default,) {final _that = this;
switch (_that) {
case _LocalSpot() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.summary,_that.imageUrl,_that.walkingMinutes,_that.petFriendly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalSpot implements LocalSpot {
  const _LocalSpot({required this.id, required this.name, required this.type, required this.summary, required this.imageUrl, required this.walkingMinutes, this.petFriendly = false});
  factory _LocalSpot.fromJson(Map<String, dynamic> json) => _$LocalSpotFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String summary;
@override final  String imageUrl;
@override final  int walkingMinutes;
@override@JsonKey() final  bool petFriendly;

/// Create a copy of LocalSpot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalSpotCopyWith<_LocalSpot> get copyWith => __$LocalSpotCopyWithImpl<_LocalSpot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalSpotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.walkingMinutes, walkingMinutes) || other.walkingMinutes == walkingMinutes)&&(identical(other.petFriendly, petFriendly) || other.petFriendly == petFriendly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,summary,imageUrl,walkingMinutes,petFriendly);

@override
String toString() {
  return 'LocalSpot(id: $id, name: $name, type: $type, summary: $summary, imageUrl: $imageUrl, walkingMinutes: $walkingMinutes, petFriendly: $petFriendly)';
}


}

/// @nodoc
abstract mixin class _$LocalSpotCopyWith<$Res> implements $LocalSpotCopyWith<$Res> {
  factory _$LocalSpotCopyWith(_LocalSpot value, $Res Function(_LocalSpot) _then) = __$LocalSpotCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String summary, String imageUrl, int walkingMinutes, bool petFriendly
});




}
/// @nodoc
class __$LocalSpotCopyWithImpl<$Res>
    implements _$LocalSpotCopyWith<$Res> {
  __$LocalSpotCopyWithImpl(this._self, this._then);

  final _LocalSpot _self;
  final $Res Function(_LocalSpot) _then;

/// Create a copy of LocalSpot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? summary = null,Object? imageUrl = null,Object? walkingMinutes = null,Object? petFriendly = null,}) {
  return _then(_LocalSpot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,walkingMinutes: null == walkingMinutes ? _self.walkingMinutes : walkingMinutes // ignore: cast_nullable_to_non_nullable
as int,petFriendly: null == petFriendly ? _self.petFriendly : petFriendly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SpotDetail {

 String get id; String get name; String get category; String get intro; String get heroImageUrl; double get lat; double get lng; String get nightHighlight; String get photoTip; String get romanticMoment; String get missionPrompt; int get missionRadiusM; List<LocalSpot> get nearbySpots; String get petPolicy; String get petNote;
/// Create a copy of SpotDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotDetailCopyWith<SpotDetail> get copyWith => _$SpotDetailCopyWithImpl<SpotDetail>(this as SpotDetail, _$identity);

  /// Serializes this SpotDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.nightHighlight, nightHighlight) || other.nightHighlight == nightHighlight)&&(identical(other.photoTip, photoTip) || other.photoTip == photoTip)&&(identical(other.romanticMoment, romanticMoment) || other.romanticMoment == romanticMoment)&&(identical(other.missionPrompt, missionPrompt) || other.missionPrompt == missionPrompt)&&(identical(other.missionRadiusM, missionRadiusM) || other.missionRadiusM == missionRadiusM)&&const DeepCollectionEquality().equals(other.nearbySpots, nearbySpots)&&(identical(other.petPolicy, petPolicy) || other.petPolicy == petPolicy)&&(identical(other.petNote, petNote) || other.petNote == petNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,intro,heroImageUrl,lat,lng,nightHighlight,photoTip,romanticMoment,missionPrompt,missionRadiusM,const DeepCollectionEquality().hash(nearbySpots),petPolicy,petNote);

@override
String toString() {
  return 'SpotDetail(id: $id, name: $name, category: $category, intro: $intro, heroImageUrl: $heroImageUrl, lat: $lat, lng: $lng, nightHighlight: $nightHighlight, photoTip: $photoTip, romanticMoment: $romanticMoment, missionPrompt: $missionPrompt, missionRadiusM: $missionRadiusM, nearbySpots: $nearbySpots, petPolicy: $petPolicy, petNote: $petNote)';
}


}

/// @nodoc
abstract mixin class $SpotDetailCopyWith<$Res>  {
  factory $SpotDetailCopyWith(SpotDetail value, $Res Function(SpotDetail) _then) = _$SpotDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String intro, String heroImageUrl, double lat, double lng, String nightHighlight, String photoTip, String romanticMoment, String missionPrompt, int missionRadiusM, List<LocalSpot> nearbySpots, String petPolicy, String petNote
});




}
/// @nodoc
class _$SpotDetailCopyWithImpl<$Res>
    implements $SpotDetailCopyWith<$Res> {
  _$SpotDetailCopyWithImpl(this._self, this._then);

  final SpotDetail _self;
  final $Res Function(SpotDetail) _then;

/// Create a copy of SpotDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? intro = null,Object? heroImageUrl = null,Object? lat = null,Object? lng = null,Object? nightHighlight = null,Object? photoTip = null,Object? romanticMoment = null,Object? missionPrompt = null,Object? missionRadiusM = null,Object? nearbySpots = null,Object? petPolicy = null,Object? petNote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,nightHighlight: null == nightHighlight ? _self.nightHighlight : nightHighlight // ignore: cast_nullable_to_non_nullable
as String,photoTip: null == photoTip ? _self.photoTip : photoTip // ignore: cast_nullable_to_non_nullable
as String,romanticMoment: null == romanticMoment ? _self.romanticMoment : romanticMoment // ignore: cast_nullable_to_non_nullable
as String,missionPrompt: null == missionPrompt ? _self.missionPrompt : missionPrompt // ignore: cast_nullable_to_non_nullable
as String,missionRadiusM: null == missionRadiusM ? _self.missionRadiusM : missionRadiusM // ignore: cast_nullable_to_non_nullable
as int,nearbySpots: null == nearbySpots ? _self.nearbySpots : nearbySpots // ignore: cast_nullable_to_non_nullable
as List<LocalSpot>,petPolicy: null == petPolicy ? _self.petPolicy : petPolicy // ignore: cast_nullable_to_non_nullable
as String,petNote: null == petNote ? _self.petNote : petNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotDetail].
extension SpotDetailPatterns on SpotDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotDetail value)  $default,){
final _that = this;
switch (_that) {
case _SpotDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SpotDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String intro,  String heroImageUrl,  double lat,  double lng,  String nightHighlight,  String photoTip,  String romanticMoment,  String missionPrompt,  int missionRadiusM,  List<LocalSpot> nearbySpots,  String petPolicy,  String petNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotDetail() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.intro,_that.heroImageUrl,_that.lat,_that.lng,_that.nightHighlight,_that.photoTip,_that.romanticMoment,_that.missionPrompt,_that.missionRadiusM,_that.nearbySpots,_that.petPolicy,_that.petNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String intro,  String heroImageUrl,  double lat,  double lng,  String nightHighlight,  String photoTip,  String romanticMoment,  String missionPrompt,  int missionRadiusM,  List<LocalSpot> nearbySpots,  String petPolicy,  String petNote)  $default,) {final _that = this;
switch (_that) {
case _SpotDetail():
return $default(_that.id,_that.name,_that.category,_that.intro,_that.heroImageUrl,_that.lat,_that.lng,_that.nightHighlight,_that.photoTip,_that.romanticMoment,_that.missionPrompt,_that.missionRadiusM,_that.nearbySpots,_that.petPolicy,_that.petNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String intro,  String heroImageUrl,  double lat,  double lng,  String nightHighlight,  String photoTip,  String romanticMoment,  String missionPrompt,  int missionRadiusM,  List<LocalSpot> nearbySpots,  String petPolicy,  String petNote)?  $default,) {final _that = this;
switch (_that) {
case _SpotDetail() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.intro,_that.heroImageUrl,_that.lat,_that.lng,_that.nightHighlight,_that.photoTip,_that.romanticMoment,_that.missionPrompt,_that.missionRadiusM,_that.nearbySpots,_that.petPolicy,_that.petNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotDetail implements SpotDetail {
  const _SpotDetail({required this.id, required this.name, required this.category, required this.intro, required this.heroImageUrl, required this.lat, required this.lng, required this.nightHighlight, required this.photoTip, required this.romanticMoment, required this.missionPrompt, required this.missionRadiusM, required final  List<LocalSpot> nearbySpots, this.petPolicy = 'partial', this.petNote = ''}): _nearbySpots = nearbySpots;
  factory _SpotDetail.fromJson(Map<String, dynamic> json) => _$SpotDetailFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String intro;
@override final  String heroImageUrl;
@override final  double lat;
@override final  double lng;
@override final  String nightHighlight;
@override final  String photoTip;
@override final  String romanticMoment;
@override final  String missionPrompt;
@override final  int missionRadiusM;
 final  List<LocalSpot> _nearbySpots;
@override List<LocalSpot> get nearbySpots {
  if (_nearbySpots is EqualUnmodifiableListView) return _nearbySpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbySpots);
}

@override@JsonKey() final  String petPolicy;
@override@JsonKey() final  String petNote;

/// Create a copy of SpotDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotDetailCopyWith<_SpotDetail> get copyWith => __$SpotDetailCopyWithImpl<_SpotDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.nightHighlight, nightHighlight) || other.nightHighlight == nightHighlight)&&(identical(other.photoTip, photoTip) || other.photoTip == photoTip)&&(identical(other.romanticMoment, romanticMoment) || other.romanticMoment == romanticMoment)&&(identical(other.missionPrompt, missionPrompt) || other.missionPrompt == missionPrompt)&&(identical(other.missionRadiusM, missionRadiusM) || other.missionRadiusM == missionRadiusM)&&const DeepCollectionEquality().equals(other._nearbySpots, _nearbySpots)&&(identical(other.petPolicy, petPolicy) || other.petPolicy == petPolicy)&&(identical(other.petNote, petNote) || other.petNote == petNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,intro,heroImageUrl,lat,lng,nightHighlight,photoTip,romanticMoment,missionPrompt,missionRadiusM,const DeepCollectionEquality().hash(_nearbySpots),petPolicy,petNote);

@override
String toString() {
  return 'SpotDetail(id: $id, name: $name, category: $category, intro: $intro, heroImageUrl: $heroImageUrl, lat: $lat, lng: $lng, nightHighlight: $nightHighlight, photoTip: $photoTip, romanticMoment: $romanticMoment, missionPrompt: $missionPrompt, missionRadiusM: $missionRadiusM, nearbySpots: $nearbySpots, petPolicy: $petPolicy, petNote: $petNote)';
}


}

/// @nodoc
abstract mixin class _$SpotDetailCopyWith<$Res> implements $SpotDetailCopyWith<$Res> {
  factory _$SpotDetailCopyWith(_SpotDetail value, $Res Function(_SpotDetail) _then) = __$SpotDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String intro, String heroImageUrl, double lat, double lng, String nightHighlight, String photoTip, String romanticMoment, String missionPrompt, int missionRadiusM, List<LocalSpot> nearbySpots, String petPolicy, String petNote
});




}
/// @nodoc
class __$SpotDetailCopyWithImpl<$Res>
    implements _$SpotDetailCopyWith<$Res> {
  __$SpotDetailCopyWithImpl(this._self, this._then);

  final _SpotDetail _self;
  final $Res Function(_SpotDetail) _then;

/// Create a copy of SpotDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? intro = null,Object? heroImageUrl = null,Object? lat = null,Object? lng = null,Object? nightHighlight = null,Object? photoTip = null,Object? romanticMoment = null,Object? missionPrompt = null,Object? missionRadiusM = null,Object? nearbySpots = null,Object? petPolicy = null,Object? petNote = null,}) {
  return _then(_SpotDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,nightHighlight: null == nightHighlight ? _self.nightHighlight : nightHighlight // ignore: cast_nullable_to_non_nullable
as String,photoTip: null == photoTip ? _self.photoTip : photoTip // ignore: cast_nullable_to_non_nullable
as String,romanticMoment: null == romanticMoment ? _self.romanticMoment : romanticMoment // ignore: cast_nullable_to_non_nullable
as String,missionPrompt: null == missionPrompt ? _self.missionPrompt : missionPrompt // ignore: cast_nullable_to_non_nullable
as String,missionRadiusM: null == missionRadiusM ? _self.missionRadiusM : missionRadiusM // ignore: cast_nullable_to_non_nullable
as int,nearbySpots: null == nearbySpots ? _self._nearbySpots : nearbySpots // ignore: cast_nullable_to_non_nullable
as List<LocalSpot>,petPolicy: null == petPolicy ? _self.petPolicy : petPolicy // ignore: cast_nullable_to_non_nullable
as String,petNote: null == petNote ? _self.petNote : petNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
