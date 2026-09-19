// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crowd_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyCrowd {

 String get date; String get level; double? get score; String get dataStatus;
/// Create a copy of DailyCrowd
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyCrowdCopyWith<DailyCrowd> get copyWith => _$DailyCrowdCopyWithImpl<DailyCrowd>(this as DailyCrowd, _$identity);

  /// Serializes this DailyCrowd to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCrowd&&(identical(other.date, date) || other.date == date)&&(identical(other.level, level) || other.level == level)&&(identical(other.score, score) || other.score == score)&&(identical(other.dataStatus, dataStatus) || other.dataStatus == dataStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,level,score,dataStatus);

@override
String toString() {
  return 'DailyCrowd(date: $date, level: $level, score: $score, dataStatus: $dataStatus)';
}


}

/// @nodoc
abstract mixin class $DailyCrowdCopyWith<$Res>  {
  factory $DailyCrowdCopyWith(DailyCrowd value, $Res Function(DailyCrowd) _then) = _$DailyCrowdCopyWithImpl;
@useResult
$Res call({
 String date, String level, double? score, String dataStatus
});




}
/// @nodoc
class _$DailyCrowdCopyWithImpl<$Res>
    implements $DailyCrowdCopyWith<$Res> {
  _$DailyCrowdCopyWithImpl(this._self, this._then);

  final DailyCrowd _self;
  final $Res Function(DailyCrowd) _then;

/// Create a copy of DailyCrowd
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? level = null,Object? score = freezed,Object? dataStatus = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,dataStatus: null == dataStatus ? _self.dataStatus : dataStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyCrowd].
extension DailyCrowdPatterns on DailyCrowd {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyCrowd value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyCrowd() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyCrowd value)  $default,){
final _that = this;
switch (_that) {
case _DailyCrowd():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyCrowd value)?  $default,){
final _that = this;
switch (_that) {
case _DailyCrowd() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String level,  double? score,  String dataStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyCrowd() when $default != null:
return $default(_that.date,_that.level,_that.score,_that.dataStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String level,  double? score,  String dataStatus)  $default,) {final _that = this;
switch (_that) {
case _DailyCrowd():
return $default(_that.date,_that.level,_that.score,_that.dataStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String level,  double? score,  String dataStatus)?  $default,) {final _that = this;
switch (_that) {
case _DailyCrowd() when $default != null:
return $default(_that.date,_that.level,_that.score,_that.dataStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyCrowd extends DailyCrowd {
  const _DailyCrowd({required this.date, this.level = 'unknown', this.score, this.dataStatus = 'unknown'}): super._();
  factory _DailyCrowd.fromJson(Map<String, dynamic> json) => _$DailyCrowdFromJson(json);

@override final  String date;
@override@JsonKey() final  String level;
@override final  double? score;
@override@JsonKey() final  String dataStatus;

/// Create a copy of DailyCrowd
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyCrowdCopyWith<_DailyCrowd> get copyWith => __$DailyCrowdCopyWithImpl<_DailyCrowd>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyCrowdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyCrowd&&(identical(other.date, date) || other.date == date)&&(identical(other.level, level) || other.level == level)&&(identical(other.score, score) || other.score == score)&&(identical(other.dataStatus, dataStatus) || other.dataStatus == dataStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,level,score,dataStatus);

@override
String toString() {
  return 'DailyCrowd(date: $date, level: $level, score: $score, dataStatus: $dataStatus)';
}


}

/// @nodoc
abstract mixin class _$DailyCrowdCopyWith<$Res> implements $DailyCrowdCopyWith<$Res> {
  factory _$DailyCrowdCopyWith(_DailyCrowd value, $Res Function(_DailyCrowd) _then) = __$DailyCrowdCopyWithImpl;
@override @useResult
$Res call({
 String date, String level, double? score, String dataStatus
});




}
/// @nodoc
class __$DailyCrowdCopyWithImpl<$Res>
    implements _$DailyCrowdCopyWith<$Res> {
  __$DailyCrowdCopyWithImpl(this._self, this._then);

  final _DailyCrowd _self;
  final $Res Function(_DailyCrowd) _then;

/// Create a copy of DailyCrowd
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? level = null,Object? score = freezed,Object? dataStatus = null,}) {
  return _then(_DailyCrowd(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double?,dataStatus: null == dataStatus ? _self.dataStatus : dataStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CrowdForecast {

 List<DailyCrowd> get days;
/// Create a copy of CrowdForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrowdForecastCopyWith<CrowdForecast> get copyWith => _$CrowdForecastCopyWithImpl<CrowdForecast>(this as CrowdForecast, _$identity);

  /// Serializes this CrowdForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrowdForecast&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'CrowdForecast(days: $days)';
}


}

/// @nodoc
abstract mixin class $CrowdForecastCopyWith<$Res>  {
  factory $CrowdForecastCopyWith(CrowdForecast value, $Res Function(CrowdForecast) _then) = _$CrowdForecastCopyWithImpl;
@useResult
$Res call({
 List<DailyCrowd> days
});




}
/// @nodoc
class _$CrowdForecastCopyWithImpl<$Res>
    implements $CrowdForecastCopyWith<$Res> {
  _$CrowdForecastCopyWithImpl(this._self, this._then);

  final CrowdForecast _self;
  final $Res Function(CrowdForecast) _then;

/// Create a copy of CrowdForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DailyCrowd>,
  ));
}

}


/// Adds pattern-matching-related methods to [CrowdForecast].
extension CrowdForecastPatterns on CrowdForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrowdForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrowdForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrowdForecast value)  $default,){
final _that = this;
switch (_that) {
case _CrowdForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrowdForecast value)?  $default,){
final _that = this;
switch (_that) {
case _CrowdForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DailyCrowd> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrowdForecast() when $default != null:
return $default(_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DailyCrowd> days)  $default,) {final _that = this;
switch (_that) {
case _CrowdForecast():
return $default(_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DailyCrowd> days)?  $default,) {final _that = this;
switch (_that) {
case _CrowdForecast() when $default != null:
return $default(_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrowdForecast extends CrowdForecast {
  const _CrowdForecast({final  List<DailyCrowd> days = const <DailyCrowd>[]}): _days = days,super._();
  factory _CrowdForecast.fromJson(Map<String, dynamic> json) => _$CrowdForecastFromJson(json);

 final  List<DailyCrowd> _days;
@override@JsonKey() List<DailyCrowd> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of CrowdForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrowdForecastCopyWith<_CrowdForecast> get copyWith => __$CrowdForecastCopyWithImpl<_CrowdForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrowdForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrowdForecast&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'CrowdForecast(days: $days)';
}


}

/// @nodoc
abstract mixin class _$CrowdForecastCopyWith<$Res> implements $CrowdForecastCopyWith<$Res> {
  factory _$CrowdForecastCopyWith(_CrowdForecast value, $Res Function(_CrowdForecast) _then) = __$CrowdForecastCopyWithImpl;
@override @useResult
$Res call({
 List<DailyCrowd> days
});




}
/// @nodoc
class __$CrowdForecastCopyWithImpl<$Res>
    implements _$CrowdForecastCopyWith<$Res> {
  __$CrowdForecastCopyWithImpl(this._self, this._then);

  final _CrowdForecast _self;
  final $Res Function(_CrowdForecast) _then;

/// Create a copy of CrowdForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,}) {
  return _then(_CrowdForecast(
days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DailyCrowd>,
  ));
}


}

// dart format on
