// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accessibility_facts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccessibilityFacts {

 String? get route; String? get exit; String? get elevator; String? get parking; String? get publicTransport; String? get wheelchair; String? get brailleBlock; String? get braillePromotion; String? get audioGuide; String? get bigPrint; String? get helpDog; String? get restroom; String? get lactationRoom; String? get stroller; String? get infantsFamily; String? get etc; String? get sourceUpdatedAt;

  /// Serializes this AccessibilityFacts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessibilityFacts&&(identical(other.route, route) || other.route == route)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.elevator, elevator) || other.elevator == elevator)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.publicTransport, publicTransport) || other.publicTransport == publicTransport)&&(identical(other.wheelchair, wheelchair) || other.wheelchair == wheelchair)&&(identical(other.brailleBlock, brailleBlock) || other.brailleBlock == brailleBlock)&&(identical(other.braillePromotion, braillePromotion) || other.braillePromotion == braillePromotion)&&(identical(other.audioGuide, audioGuide) || other.audioGuide == audioGuide)&&(identical(other.bigPrint, bigPrint) || other.bigPrint == bigPrint)&&(identical(other.helpDog, helpDog) || other.helpDog == helpDog)&&(identical(other.restroom, restroom) || other.restroom == restroom)&&(identical(other.lactationRoom, lactationRoom) || other.lactationRoom == lactationRoom)&&(identical(other.stroller, stroller) || other.stroller == stroller)&&(identical(other.infantsFamily, infantsFamily) || other.infantsFamily == infantsFamily)&&(identical(other.etc, etc) || other.etc == etc)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,exit,elevator,parking,publicTransport,wheelchair,brailleBlock,braillePromotion,audioGuide,bigPrint,helpDog,restroom,lactationRoom,stroller,infantsFamily,etc,sourceUpdatedAt);

@override
String toString() {
  return 'AccessibilityFacts(route: $route, exit: $exit, elevator: $elevator, parking: $parking, publicTransport: $publicTransport, wheelchair: $wheelchair, brailleBlock: $brailleBlock, braillePromotion: $braillePromotion, audioGuide: $audioGuide, bigPrint: $bigPrint, helpDog: $helpDog, restroom: $restroom, lactationRoom: $lactationRoom, stroller: $stroller, infantsFamily: $infantsFamily, etc: $etc, sourceUpdatedAt: $sourceUpdatedAt)';
}


}




/// Adds pattern-matching-related methods to [AccessibilityFacts].
extension AccessibilityFactsPatterns on AccessibilityFacts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccessibilityFacts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccessibilityFacts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccessibilityFacts value)  $default,){
final _that = this;
switch (_that) {
case _AccessibilityFacts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccessibilityFacts value)?  $default,){
final _that = this;
switch (_that) {
case _AccessibilityFacts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? route,  String? exit,  String? elevator,  String? parking,  String? publicTransport,  String? wheelchair,  String? brailleBlock,  String? braillePromotion,  String? audioGuide,  String? bigPrint,  String? helpDog,  String? restroom,  String? lactationRoom,  String? stroller,  String? infantsFamily,  String? etc,  String? sourceUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccessibilityFacts() when $default != null:
return $default(_that.route,_that.exit,_that.elevator,_that.parking,_that.publicTransport,_that.wheelchair,_that.brailleBlock,_that.braillePromotion,_that.audioGuide,_that.bigPrint,_that.helpDog,_that.restroom,_that.lactationRoom,_that.stroller,_that.infantsFamily,_that.etc,_that.sourceUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? route,  String? exit,  String? elevator,  String? parking,  String? publicTransport,  String? wheelchair,  String? brailleBlock,  String? braillePromotion,  String? audioGuide,  String? bigPrint,  String? helpDog,  String? restroom,  String? lactationRoom,  String? stroller,  String? infantsFamily,  String? etc,  String? sourceUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _AccessibilityFacts():
return $default(_that.route,_that.exit,_that.elevator,_that.parking,_that.publicTransport,_that.wheelchair,_that.brailleBlock,_that.braillePromotion,_that.audioGuide,_that.bigPrint,_that.helpDog,_that.restroom,_that.lactationRoom,_that.stroller,_that.infantsFamily,_that.etc,_that.sourceUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? route,  String? exit,  String? elevator,  String? parking,  String? publicTransport,  String? wheelchair,  String? brailleBlock,  String? braillePromotion,  String? audioGuide,  String? bigPrint,  String? helpDog,  String? restroom,  String? lactationRoom,  String? stroller,  String? infantsFamily,  String? etc,  String? sourceUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AccessibilityFacts() when $default != null:
return $default(_that.route,_that.exit,_that.elevator,_that.parking,_that.publicTransport,_that.wheelchair,_that.brailleBlock,_that.braillePromotion,_that.audioGuide,_that.bigPrint,_that.helpDog,_that.restroom,_that.lactationRoom,_that.stroller,_that.infantsFamily,_that.etc,_that.sourceUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccessibilityFacts extends AccessibilityFacts {
  const _AccessibilityFacts({this.route, this.exit, this.elevator, this.parking, this.publicTransport, this.wheelchair, this.brailleBlock, this.braillePromotion, this.audioGuide, this.bigPrint, this.helpDog, this.restroom, this.lactationRoom, this.stroller, this.infantsFamily, this.etc, this.sourceUpdatedAt}): super._();
  factory _AccessibilityFacts.fromJson(Map<String, dynamic> json) => _$AccessibilityFactsFromJson(json);

@override final  String? route;
@override final  String? exit;
@override final  String? elevator;
@override final  String? parking;
@override final  String? publicTransport;
@override final  String? wheelchair;
@override final  String? brailleBlock;
@override final  String? braillePromotion;
@override final  String? audioGuide;
@override final  String? bigPrint;
@override final  String? helpDog;
@override final  String? restroom;
@override final  String? lactationRoom;
@override final  String? stroller;
@override final  String? infantsFamily;
@override final  String? etc;
@override final  String? sourceUpdatedAt;


@override
Map<String, dynamic> toJson() {
  return _$AccessibilityFactsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccessibilityFacts&&(identical(other.route, route) || other.route == route)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.elevator, elevator) || other.elevator == elevator)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.publicTransport, publicTransport) || other.publicTransport == publicTransport)&&(identical(other.wheelchair, wheelchair) || other.wheelchair == wheelchair)&&(identical(other.brailleBlock, brailleBlock) || other.brailleBlock == brailleBlock)&&(identical(other.braillePromotion, braillePromotion) || other.braillePromotion == braillePromotion)&&(identical(other.audioGuide, audioGuide) || other.audioGuide == audioGuide)&&(identical(other.bigPrint, bigPrint) || other.bigPrint == bigPrint)&&(identical(other.helpDog, helpDog) || other.helpDog == helpDog)&&(identical(other.restroom, restroom) || other.restroom == restroom)&&(identical(other.lactationRoom, lactationRoom) || other.lactationRoom == lactationRoom)&&(identical(other.stroller, stroller) || other.stroller == stroller)&&(identical(other.infantsFamily, infantsFamily) || other.infantsFamily == infantsFamily)&&(identical(other.etc, etc) || other.etc == etc)&&(identical(other.sourceUpdatedAt, sourceUpdatedAt) || other.sourceUpdatedAt == sourceUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,exit,elevator,parking,publicTransport,wheelchair,brailleBlock,braillePromotion,audioGuide,bigPrint,helpDog,restroom,lactationRoom,stroller,infantsFamily,etc,sourceUpdatedAt);

@override
String toString() {
  return 'AccessibilityFacts(route: $route, exit: $exit, elevator: $elevator, parking: $parking, publicTransport: $publicTransport, wheelchair: $wheelchair, brailleBlock: $brailleBlock, braillePromotion: $braillePromotion, audioGuide: $audioGuide, bigPrint: $bigPrint, helpDog: $helpDog, restroom: $restroom, lactationRoom: $lactationRoom, stroller: $stroller, infantsFamily: $infantsFamily, etc: $etc, sourceUpdatedAt: $sourceUpdatedAt)';
}


}




// dart format on
