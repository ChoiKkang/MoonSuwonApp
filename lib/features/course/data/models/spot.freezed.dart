// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Spot _$SpotFromJson(Map<String, dynamic> json) {
  return _Spot.fromJson(json);
}

/// @nodoc
mixin _$Spot {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  int get missionRadiusM => throw _privateConstructorUsedError;
  String get missionPrompt => throw _privateConstructorUsedError;
  SpotProgressStatus get status => throw _privateConstructorUsedError;
  String get petPolicy => throw _privateConstructorUsedError;
  String get petNote => throw _privateConstructorUsedError;

  /// Serializes this Spot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotCopyWith<Spot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotCopyWith<$Res> {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) then) =
      _$SpotCopyWithImpl<$Res, Spot>;
  @useResult
  $Res call({
    String id,
    String name,
    String summary,
    String imageUrl,
    double lat,
    double lng,
    int missionRadiusM,
    String missionPrompt,
    SpotProgressStatus status,
    String petPolicy,
    String petNote,
  });
}

/// @nodoc
class _$SpotCopyWithImpl<$Res, $Val extends Spot>
    implements $SpotCopyWith<$Res> {
  _$SpotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? lat = null,
    Object? lng = null,
    Object? missionRadiusM = null,
    Object? missionPrompt = null,
    Object? status = null,
    Object? petPolicy = null,
    Object? petNote = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            missionRadiusM: null == missionRadiusM
                ? _value.missionRadiusM
                : missionRadiusM // ignore: cast_nullable_to_non_nullable
                      as int,
            missionPrompt: null == missionPrompt
                ? _value.missionPrompt
                : missionPrompt // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SpotProgressStatus,
            petPolicy: null == petPolicy
                ? _value.petPolicy
                : petPolicy // ignore: cast_nullable_to_non_nullable
                      as String,
            petNote: null == petNote
                ? _value.petNote
                : petNote // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotImplCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$$SpotImplCopyWith(
    _$SpotImpl value,
    $Res Function(_$SpotImpl) then,
  ) = __$$SpotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String summary,
    String imageUrl,
    double lat,
    double lng,
    int missionRadiusM,
    String missionPrompt,
    SpotProgressStatus status,
    String petPolicy,
    String petNote,
  });
}

/// @nodoc
class __$$SpotImplCopyWithImpl<$Res>
    extends _$SpotCopyWithImpl<$Res, _$SpotImpl>
    implements _$$SpotImplCopyWith<$Res> {
  __$$SpotImplCopyWithImpl(_$SpotImpl _value, $Res Function(_$SpotImpl) _then)
    : super(_value, _then);

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? lat = null,
    Object? lng = null,
    Object? missionRadiusM = null,
    Object? missionPrompt = null,
    Object? status = null,
    Object? petPolicy = null,
    Object? petNote = null,
  }) {
    return _then(
      _$SpotImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        missionRadiusM: null == missionRadiusM
            ? _value.missionRadiusM
            : missionRadiusM // ignore: cast_nullable_to_non_nullable
                  as int,
        missionPrompt: null == missionPrompt
            ? _value.missionPrompt
            : missionPrompt // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SpotProgressStatus,
        petPolicy: null == petPolicy
            ? _value.petPolicy
            : petPolicy // ignore: cast_nullable_to_non_nullable
                  as String,
        petNote: null == petNote
            ? _value.petNote
            : petNote // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotImpl implements _Spot {
  const _$SpotImpl({
    required this.id,
    required this.name,
    required this.summary,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    required this.missionRadiusM,
    required this.missionPrompt,
    this.status = SpotProgressStatus.pending,
    this.petPolicy = 'partial',
    this.petNote = '',
  });

  factory _$SpotImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String summary;
  @override
  final String imageUrl;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final int missionRadiusM;
  @override
  final String missionPrompt;
  @override
  @JsonKey()
  final SpotProgressStatus status;
  @override
  @JsonKey()
  final String petPolicy;
  @override
  @JsonKey()
  final String petNote;

  @override
  String toString() {
    return 'Spot(id: $id, name: $name, summary: $summary, imageUrl: $imageUrl, lat: $lat, lng: $lng, missionRadiusM: $missionRadiusM, missionPrompt: $missionPrompt, status: $status, petPolicy: $petPolicy, petNote: $petNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.missionRadiusM, missionRadiusM) ||
                other.missionRadiusM == missionRadiusM) &&
            (identical(other.missionPrompt, missionPrompt) ||
                other.missionPrompt == missionPrompt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.petPolicy, petPolicy) ||
                other.petPolicy == petPolicy) &&
            (identical(other.petNote, petNote) || other.petNote == petNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    summary,
    imageUrl,
    lat,
    lng,
    missionRadiusM,
    missionPrompt,
    status,
    petPolicy,
    petNote,
  );

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      __$$SpotImplCopyWithImpl<_$SpotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotImplToJson(this);
  }
}

abstract class _Spot implements Spot {
  const factory _Spot({
    required final String id,
    required final String name,
    required final String summary,
    required final String imageUrl,
    required final double lat,
    required final double lng,
    required final int missionRadiusM,
    required final String missionPrompt,
    final SpotProgressStatus status,
    final String petPolicy,
    final String petNote,
  }) = _$SpotImpl;

  factory _Spot.fromJson(Map<String, dynamic> json) = _$SpotImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get summary;
  @override
  String get imageUrl;
  @override
  double get lat;
  @override
  double get lng;
  @override
  int get missionRadiusM;
  @override
  String get missionPrompt;
  @override
  SpotProgressStatus get status;
  @override
  String get petPolicy;
  @override
  String get petNote;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
