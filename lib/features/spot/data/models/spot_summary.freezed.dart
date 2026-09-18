// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotSummary {

 String get id; String get slug; String get name; String get category; String get heroImageUrl; String? get crowdLevel; double? get distanceM; String get reasonLabel; double get recommendationScore; String get forecastStatus;
/// Create a copy of SpotSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotSummaryCopyWith<SpotSummary> get copyWith => _$SpotSummaryCopyWithImpl<SpotSummary>(this as SpotSummary, _$identity);

  /// Serializes this SpotSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.crowdLevel, crowdLevel) || other.crowdLevel == crowdLevel)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&(identical(other.reasonLabel, reasonLabel) || other.reasonLabel == reasonLabel)&&(identical(other.recommendationScore, recommendationScore) || other.recommendationScore == recommendationScore)&&(identical(other.forecastStatus, forecastStatus) || other.forecastStatus == forecastStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,category,heroImageUrl,crowdLevel,distanceM,reasonLabel,recommendationScore,forecastStatus);

@override
String toString() {
  return 'SpotSummary(id: $id, slug: $slug, name: $name, category: $category, heroImageUrl: $heroImageUrl, crowdLevel: $crowdLevel, distanceM: $distanceM, reasonLabel: $reasonLabel, recommendationScore: $recommendationScore, forecastStatus: $forecastStatus)';
}


}

/// @nodoc
abstract mixin class $SpotSummaryCopyWith<$Res>  {
  factory $SpotSummaryCopyWith(SpotSummary value, $Res Function(SpotSummary) _then) = _$SpotSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String slug, String name, String category, String heroImageUrl, String? crowdLevel, double? distanceM, String reasonLabel, double recommendationScore, String forecastStatus
});




}
/// @nodoc
class _$SpotSummaryCopyWithImpl<$Res>
    implements $SpotSummaryCopyWith<$Res> {
  _$SpotSummaryCopyWithImpl(this._self, this._then);

  final SpotSummary _self;
  final $Res Function(SpotSummary) _then;

/// Create a copy of SpotSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? category = null,Object? heroImageUrl = null,Object? crowdLevel = freezed,Object? distanceM = freezed,Object? reasonLabel = null,Object? recommendationScore = null,Object? forecastStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,crowdLevel: freezed == crowdLevel ? _self.crowdLevel : crowdLevel // ignore: cast_nullable_to_non_nullable
as String?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double?,reasonLabel: null == reasonLabel ? _self.reasonLabel : reasonLabel // ignore: cast_nullable_to_non_nullable
as String,recommendationScore: null == recommendationScore ? _self.recommendationScore : recommendationScore // ignore: cast_nullable_to_non_nullable
as double,forecastStatus: null == forecastStatus ? _self.forecastStatus : forecastStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotSummary].
extension SpotSummaryPatterns on SpotSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotSummary value)  $default,){
final _that = this;
switch (_that) {
case _SpotSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SpotSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String slug,  String name,  String category,  String heroImageUrl,  String? crowdLevel,  double? distanceM,  String reasonLabel,  double recommendationScore,  String forecastStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotSummary() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.category,_that.heroImageUrl,_that.crowdLevel,_that.distanceM,_that.reasonLabel,_that.recommendationScore,_that.forecastStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String slug,  String name,  String category,  String heroImageUrl,  String? crowdLevel,  double? distanceM,  String reasonLabel,  double recommendationScore,  String forecastStatus)  $default,) {final _that = this;
switch (_that) {
case _SpotSummary():
return $default(_that.id,_that.slug,_that.name,_that.category,_that.heroImageUrl,_that.crowdLevel,_that.distanceM,_that.reasonLabel,_that.recommendationScore,_that.forecastStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String slug,  String name,  String category,  String heroImageUrl,  String? crowdLevel,  double? distanceM,  String reasonLabel,  double recommendationScore,  String forecastStatus)?  $default,) {final _that = this;
switch (_that) {
case _SpotSummary() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.category,_that.heroImageUrl,_that.crowdLevel,_that.distanceM,_that.reasonLabel,_that.recommendationScore,_that.forecastStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotSummary implements SpotSummary {
  const _SpotSummary({required this.id, required this.slug, required this.name, required this.category, required this.heroImageUrl, this.crowdLevel, this.distanceM, required this.reasonLabel, required this.recommendationScore, required this.forecastStatus});
  factory _SpotSummary.fromJson(Map<String, dynamic> json) => _$SpotSummaryFromJson(json);

@override final  String id;
@override final  String slug;
@override final  String name;
@override final  String category;
@override final  String heroImageUrl;
@override final  String? crowdLevel;
@override final  double? distanceM;
@override final  String reasonLabel;
@override final  double recommendationScore;
@override final  String forecastStatus;

/// Create a copy of SpotSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotSummaryCopyWith<_SpotSummary> get copyWith => __$SpotSummaryCopyWithImpl<_SpotSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.heroImageUrl, heroImageUrl) || other.heroImageUrl == heroImageUrl)&&(identical(other.crowdLevel, crowdLevel) || other.crowdLevel == crowdLevel)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&(identical(other.reasonLabel, reasonLabel) || other.reasonLabel == reasonLabel)&&(identical(other.recommendationScore, recommendationScore) || other.recommendationScore == recommendationScore)&&(identical(other.forecastStatus, forecastStatus) || other.forecastStatus == forecastStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,category,heroImageUrl,crowdLevel,distanceM,reasonLabel,recommendationScore,forecastStatus);

@override
String toString() {
  return 'SpotSummary(id: $id, slug: $slug, name: $name, category: $category, heroImageUrl: $heroImageUrl, crowdLevel: $crowdLevel, distanceM: $distanceM, reasonLabel: $reasonLabel, recommendationScore: $recommendationScore, forecastStatus: $forecastStatus)';
}


}

/// @nodoc
abstract mixin class _$SpotSummaryCopyWith<$Res> implements $SpotSummaryCopyWith<$Res> {
  factory _$SpotSummaryCopyWith(_SpotSummary value, $Res Function(_SpotSummary) _then) = __$SpotSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String slug, String name, String category, String heroImageUrl, String? crowdLevel, double? distanceM, String reasonLabel, double recommendationScore, String forecastStatus
});




}
/// @nodoc
class __$SpotSummaryCopyWithImpl<$Res>
    implements _$SpotSummaryCopyWith<$Res> {
  __$SpotSummaryCopyWithImpl(this._self, this._then);

  final _SpotSummary _self;
  final $Res Function(_SpotSummary) _then;

/// Create a copy of SpotSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? category = null,Object? heroImageUrl = null,Object? crowdLevel = freezed,Object? distanceM = freezed,Object? reasonLabel = null,Object? recommendationScore = null,Object? forecastStatus = null,}) {
  return _then(_SpotSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,heroImageUrl: null == heroImageUrl ? _self.heroImageUrl : heroImageUrl // ignore: cast_nullable_to_non_nullable
as String,crowdLevel: freezed == crowdLevel ? _self.crowdLevel : crowdLevel // ignore: cast_nullable_to_non_nullable
as String?,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as double?,reasonLabel: null == reasonLabel ? _self.reasonLabel : reasonLabel // ignore: cast_nullable_to_non_nullable
as String,recommendationScore: null == recommendationScore ? _self.recommendationScore : recommendationScore // ignore: cast_nullable_to_non_nullable
as double,forecastStatus: null == forecastStatus ? _self.forecastStatus : forecastStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
