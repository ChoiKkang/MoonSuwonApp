// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseSummary {

 String get id; String get title; String get subtitle; int get estimatedDurationMin; double get walkingDistanceKm; String get recommendedStartTime; int get spotCount; String get heroImageUrl; List<String> get themeTags; bool get petReadyFlag;
/// Create a copy of CourseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseSummaryCopyWith<CourseSummary> get copyWith => _$CourseSummaryCopyWithImpl<CourseSummary>(this as CourseSummary, _$identity);

  /// Serializes this CourseSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.estimatedDurationMin, estimatedDurationMin) || other.estimatedDurationMin == estimatedDurationMin)&&(identical(other.walkingDistanceKm, walkingDistanceKm) || other.walkingDistanceKm == walkingDistanceKm)&&(identical(other.recommendedStartTime, recommendedStartTime) || other.recommendedStartTime == recommendedStartTime)&&(identical(other.spotCount, spotCount) || other.spotCount == spotCount)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&const DeepCollectionEquality().equals(other.themeTags, themeTags)&&(identical(other.petReadyFlag, petReadyFlag) || other.petReadyFlag == petReadyFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,estimatedDurationMin,walkingDistanceKm,recommendedStartTime,spotCount,heroImageUrl,const DeepCollectionEquality().hash(themeTags),petReadyFlag);

@override
String toString() {
  return 'CourseSummary(id: $id, title: $title, subtitle: $subtitle, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, spotCount: $spotCount, heroImageUrl: $heroImageUrl, themeTags: $themeTags, petReadyFlag: $petReadyFlag)';
}


}

/// @nodoc
abstract mixin class $CourseSummaryCopyWith<$Res>  {
  factory $CourseSummaryCopyWith(CourseSummary value, $Res Function(CourseSummary) _then) = _$CourseSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, int estimatedDurationMin, double walkingDistanceKm, String recommendedStartTime, int spotCount, String heroImageUrl, List<String> themeTags, bool petReadyFlag
});




}
/// @nodoc
class _$CourseSummaryCopyWithImpl<$Res>
    implements $CourseSummaryCopyWith<$Res> {
  _$CourseSummaryCopyWithImpl(this._self, this._then);

  final CourseSummary _self;
  final $Res Function(CourseSummary) _then;

/// Create a copy of CourseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? estimatedDurationMin = null,Object? walkingDistanceKm = null,Object? recommendedStartTime = null,Object? spotCount = null,Object? heroImageUrl = null,Object? themeTags = null,Object? petReadyFlag = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,estimatedDurationMin: null == estimatedDurationMin ? _self.estimatedDurationMin : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
as int,walkingDistanceKm: null == walkingDistanceKm ? _self.walkingDistanceKm : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
as double,recommendedStartTime: null == recommendedStartTime ? _self.recommendedStartTime : recommendedStartTime // ignore: cast_nullable_to_non_nullable
as String,spotCount: null == spotCount ? _self.spotCount : spotCount // ignore: cast_nullable_to_non_nullable
as int,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,themeTags: null == themeTags ? _self.themeTags : themeTags // ignore: cast_nullable_to_non_nullable
as List<String>,petReadyFlag: null == petReadyFlag ? _self.petReadyFlag : petReadyFlag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseSummary].
extension CourseSummaryPatterns on CourseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseSummary value)  $default,){
final _that = this;
switch (_that) {
case _CourseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CourseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  int spotCount,  String heroImageUrl,  List<String> themeTags,  bool petReadyFlag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseSummary() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.spotCount,_that.heroImageUrl,_that.themeTags,_that.petReadyFlag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  int spotCount,  String heroImageUrl,  List<String> themeTags,  bool petReadyFlag)  $default,) {final _that = this;
switch (_that) {
case _CourseSummary():
return $default(_that.id,_that.title,_that.subtitle,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.spotCount,_that.heroImageUrl,_that.themeTags,_that.petReadyFlag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  int spotCount,  String heroImageUrl,  List<String> themeTags,  bool petReadyFlag)?  $default,) {final _that = this;
switch (_that) {
case _CourseSummary() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.spotCount,_that.heroImageUrl,_that.themeTags,_that.petReadyFlag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseSummary implements CourseSummary {
  const _CourseSummary({required this.id, required this.title, required this.subtitle, required this.estimatedDurationMin, required this.walkingDistanceKm, required this.recommendedStartTime, required this.spotCount, required this.heroImageUrl, required final  List<String> themeTags, this.petReadyFlag = false}): _themeTags = themeTags;
  factory _CourseSummary.fromJson(Map<String, dynamic> json) => _$CourseSummaryFromJson(json);

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  int estimatedDurationMin;
@override final  double walkingDistanceKm;
@override final  String recommendedStartTime;
@override final  int spotCount;
@override final  String heroImageUrl;
 final  List<String> _themeTags;
@override List<String> get themeTags {
  if (_themeTags is EqualUnmodifiableListView) return _themeTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_themeTags);
}

@override@JsonKey() final  bool petReadyFlag;

/// Create a copy of CourseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseSummaryCopyWith<_CourseSummary> get copyWith => __$CourseSummaryCopyWithImpl<_CourseSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.estimatedDurationMin, estimatedDurationMin) || other.estimatedDurationMin == estimatedDurationMin)&&(identical(other.walkingDistanceKm, walkingDistanceKm) || other.walkingDistanceKm == walkingDistanceKm)&&(identical(other.recommendedStartTime, recommendedStartTime) || other.recommendedStartTime == recommendedStartTime)&&(identical(other.spotCount, spotCount) || other.spotCount == spotCount)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&const DeepCollectionEquality().equals(other._themeTags, _themeTags)&&(identical(other.petReadyFlag, petReadyFlag) || other.petReadyFlag == petReadyFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,estimatedDurationMin,walkingDistanceKm,recommendedStartTime,spotCount,heroImageUrl,const DeepCollectionEquality().hash(_themeTags),petReadyFlag);

@override
String toString() {
  return 'CourseSummary(id: $id, title: $title, subtitle: $subtitle, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, spotCount: $spotCount, heroImageUrl: $heroImageUrl, themeTags: $themeTags, petReadyFlag: $petReadyFlag)';
}


}

/// @nodoc
abstract mixin class _$CourseSummaryCopyWith<$Res> implements $CourseSummaryCopyWith<$Res> {
  factory _$CourseSummaryCopyWith(_CourseSummary value, $Res Function(_CourseSummary) _then) = __$CourseSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, int estimatedDurationMin, double walkingDistanceKm, String recommendedStartTime, int spotCount, String heroImageUrl, List<String> themeTags, bool petReadyFlag
});




}
/// @nodoc
class __$CourseSummaryCopyWithImpl<$Res>
    implements _$CourseSummaryCopyWith<$Res> {
  __$CourseSummaryCopyWithImpl(this._self, this._then);

  final _CourseSummary _self;
  final $Res Function(_CourseSummary) _then;

/// Create a copy of CourseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? estimatedDurationMin = null,Object? walkingDistanceKm = null,Object? recommendedStartTime = null,Object? spotCount = null,Object? heroImageUrl = null,Object? themeTags = null,Object? petReadyFlag = null,}) {
  return _then(_CourseSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,estimatedDurationMin: null == estimatedDurationMin ? _self.estimatedDurationMin : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
as int,walkingDistanceKm: null == walkingDistanceKm ? _self.walkingDistanceKm : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
as double,recommendedStartTime: null == recommendedStartTime ? _self.recommendedStartTime : recommendedStartTime // ignore: cast_nullable_to_non_nullable
as String,spotCount: null == spotCount ? _self.spotCount : spotCount // ignore: cast_nullable_to_non_nullable
as int,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,themeTags: null == themeTags ? _self._themeTags : themeTags // ignore: cast_nullable_to_non_nullable
as List<String>,petReadyFlag: null == petReadyFlag ? _self.petReadyFlag : petReadyFlag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CourseDetail {

 String get id; String get title; String get subtitle; String get description; int get estimatedDurationMin; double get walkingDistanceKm; String get recommendedStartTime; String get heroImageUrl; List<String> get themeTags; List<Spot> get spots; bool get petReadyFlag;
/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailCopyWith<CourseDetail> get copyWith => _$CourseDetailCopyWithImpl<CourseDetail>(this as CourseDetail, _$identity);

  /// Serializes this CourseDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.estimatedDurationMin, estimatedDurationMin) || other.estimatedDurationMin == estimatedDurationMin)&&(identical(other.walkingDistanceKm, walkingDistanceKm) || other.walkingDistanceKm == walkingDistanceKm)&&(identical(other.recommendedStartTime, recommendedStartTime) || other.recommendedStartTime == recommendedStartTime)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&const DeepCollectionEquality().equals(other.themeTags, themeTags)&&const DeepCollectionEquality().equals(other.spots, spots)&&(identical(other.petReadyFlag, petReadyFlag) || other.petReadyFlag == petReadyFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,description,estimatedDurationMin,walkingDistanceKm,recommendedStartTime,heroImageUrl,const DeepCollectionEquality().hash(themeTags),const DeepCollectionEquality().hash(spots),petReadyFlag);

@override
String toString() {
  return 'CourseDetail(id: $id, title: $title, subtitle: $subtitle, description: $description, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, heroImageUrl: $heroImageUrl, themeTags: $themeTags, spots: $spots, petReadyFlag: $petReadyFlag)';
}


}

/// @nodoc
abstract mixin class $CourseDetailCopyWith<$Res>  {
  factory $CourseDetailCopyWith(CourseDetail value, $Res Function(CourseDetail) _then) = _$CourseDetailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, String description, int estimatedDurationMin, double walkingDistanceKm, String recommendedStartTime, String heroImageUrl, List<String> themeTags, List<Spot> spots, bool petReadyFlag
});




}
/// @nodoc
class _$CourseDetailCopyWithImpl<$Res>
    implements $CourseDetailCopyWith<$Res> {
  _$CourseDetailCopyWithImpl(this._self, this._then);

  final CourseDetail _self;
  final $Res Function(CourseDetail) _then;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? description = null,Object? estimatedDurationMin = null,Object? walkingDistanceKm = null,Object? recommendedStartTime = null,Object? heroImageUrl = null,Object? themeTags = null,Object? spots = null,Object? petReadyFlag = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,estimatedDurationMin: null == estimatedDurationMin ? _self.estimatedDurationMin : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
as int,walkingDistanceKm: null == walkingDistanceKm ? _self.walkingDistanceKm : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
as double,recommendedStartTime: null == recommendedStartTime ? _self.recommendedStartTime : recommendedStartTime // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,themeTags: null == themeTags ? _self.themeTags : themeTags // ignore: cast_nullable_to_non_nullable
as List<String>,spots: null == spots ? _self.spots : spots // ignore: cast_nullable_to_non_nullable
as List<Spot>,petReadyFlag: null == petReadyFlag ? _self.petReadyFlag : petReadyFlag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseDetail].
extension CourseDetailPatterns on CourseDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseDetail value)  $default,){
final _that = this;
switch (_that) {
case _CourseDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseDetail value)?  $default,){
final _that = this;
switch (_that) {
case _CourseDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String description,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  String heroImageUrl,  List<String> themeTags,  List<Spot> spots,  bool petReadyFlag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseDetail() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.heroImageUrl,_that.themeTags,_that.spots,_that.petReadyFlag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String description,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  String heroImageUrl,  List<String> themeTags,  List<Spot> spots,  bool petReadyFlag)  $default,) {final _that = this;
switch (_that) {
case _CourseDetail():
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.heroImageUrl,_that.themeTags,_that.spots,_that.petReadyFlag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  String description,  int estimatedDurationMin,  double walkingDistanceKm,  String recommendedStartTime,  String heroImageUrl,  List<String> themeTags,  List<Spot> spots,  bool petReadyFlag)?  $default,) {final _that = this;
switch (_that) {
case _CourseDetail() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.estimatedDurationMin,_that.walkingDistanceKm,_that.recommendedStartTime,_that.heroImageUrl,_that.themeTags,_that.spots,_that.petReadyFlag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseDetail implements CourseDetail {
  const _CourseDetail({required this.id, required this.title, required this.subtitle, required this.description, required this.estimatedDurationMin, required this.walkingDistanceKm, required this.recommendedStartTime, required this.heroImageUrl, required final  List<String> themeTags, required final  List<Spot> spots, this.petReadyFlag = false}): _themeTags = themeTags,_spots = spots;
  factory _CourseDetail.fromJson(Map<String, dynamic> json) => _$CourseDetailFromJson(json);

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  String description;
@override final  int estimatedDurationMin;
@override final  double walkingDistanceKm;
@override final  String recommendedStartTime;
@override final  String heroImageUrl;
 final  List<String> _themeTags;
@override List<String> get themeTags {
  if (_themeTags is EqualUnmodifiableListView) return _themeTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_themeTags);
}

 final  List<Spot> _spots;
@override List<Spot> get spots {
  if (_spots is EqualUnmodifiableListView) return _spots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spots);
}

@override@JsonKey() final  bool petReadyFlag;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseDetailCopyWith<_CourseDetail> get copyWith => __$CourseDetailCopyWithImpl<_CourseDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.estimatedDurationMin, estimatedDurationMin) || other.estimatedDurationMin == estimatedDurationMin)&&(identical(other.walkingDistanceKm, walkingDistanceKm) || other.walkingDistanceKm == walkingDistanceKm)&&(identical(other.recommendedStartTime, recommendedStartTime) || other.recommendedStartTime == recommendedStartTime)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&const DeepCollectionEquality().equals(other._themeTags, _themeTags)&&const DeepCollectionEquality().equals(other._spots, _spots)&&(identical(other.petReadyFlag, petReadyFlag) || other.petReadyFlag == petReadyFlag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,description,estimatedDurationMin,walkingDistanceKm,recommendedStartTime,heroImageUrl,const DeepCollectionEquality().hash(_themeTags),const DeepCollectionEquality().hash(_spots),petReadyFlag);

@override
String toString() {
  return 'CourseDetail(id: $id, title: $title, subtitle: $subtitle, description: $description, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, heroImageUrl: $heroImageUrl, themeTags: $themeTags, spots: $spots, petReadyFlag: $petReadyFlag)';
}


}

/// @nodoc
abstract mixin class _$CourseDetailCopyWith<$Res> implements $CourseDetailCopyWith<$Res> {
  factory _$CourseDetailCopyWith(_CourseDetail value, $Res Function(_CourseDetail) _then) = __$CourseDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, String description, int estimatedDurationMin, double walkingDistanceKm, String recommendedStartTime, String heroImageUrl, List<String> themeTags, List<Spot> spots, bool petReadyFlag
});




}
/// @nodoc
class __$CourseDetailCopyWithImpl<$Res>
    implements _$CourseDetailCopyWith<$Res> {
  __$CourseDetailCopyWithImpl(this._self, this._then);

  final _CourseDetail _self;
  final $Res Function(_CourseDetail) _then;

/// Create a copy of CourseDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? description = null,Object? estimatedDurationMin = null,Object? walkingDistanceKm = null,Object? recommendedStartTime = null,Object? heroImageUrl = null,Object? themeTags = null,Object? spots = null,Object? petReadyFlag = null,}) {
  return _then(_CourseDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,estimatedDurationMin: null == estimatedDurationMin ? _self.estimatedDurationMin : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
as int,walkingDistanceKm: null == walkingDistanceKm ? _self.walkingDistanceKm : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
as double,recommendedStartTime: null == recommendedStartTime ? _self.recommendedStartTime : recommendedStartTime // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,themeTags: null == themeTags ? _self._themeTags : themeTags // ignore: cast_nullable_to_non_nullable
as List<String>,spots: null == spots ? _self._spots : spots // ignore: cast_nullable_to_non_nullable
as List<Spot>,petReadyFlag: null == petReadyFlag ? _self.petReadyFlag : petReadyFlag // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
