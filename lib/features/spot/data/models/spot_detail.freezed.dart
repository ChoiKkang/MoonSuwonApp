// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalSpot _$LocalSpotFromJson(Map<String, dynamic> json) {
  return _LocalSpot.fromJson(json);
}

/// @nodoc
mixin _$LocalSpot {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get walkingMinutes => throw _privateConstructorUsedError;
  bool get petFriendly => throw _privateConstructorUsedError;

  /// Serializes this LocalSpot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalSpot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalSpotCopyWith<LocalSpot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalSpotCopyWith<$Res> {
  factory $LocalSpotCopyWith(LocalSpot value, $Res Function(LocalSpot) then) =
      _$LocalSpotCopyWithImpl<$Res, LocalSpot>;
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String summary,
    String imageUrl,
    int walkingMinutes,
    bool petFriendly,
  });
}

/// @nodoc
class _$LocalSpotCopyWithImpl<$Res, $Val extends LocalSpot>
    implements $LocalSpotCopyWith<$Res> {
  _$LocalSpotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalSpot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? walkingMinutes = null,
    Object? petFriendly = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            walkingMinutes: null == walkingMinutes
                ? _value.walkingMinutes
                : walkingMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            petFriendly: null == petFriendly
                ? _value.petFriendly
                : petFriendly // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalSpotImplCopyWith<$Res>
    implements $LocalSpotCopyWith<$Res> {
  factory _$$LocalSpotImplCopyWith(
    _$LocalSpotImpl value,
    $Res Function(_$LocalSpotImpl) then,
  ) = __$$LocalSpotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String type,
    String summary,
    String imageUrl,
    int walkingMinutes,
    bool petFriendly,
  });
}

/// @nodoc
class __$$LocalSpotImplCopyWithImpl<$Res>
    extends _$LocalSpotCopyWithImpl<$Res, _$LocalSpotImpl>
    implements _$$LocalSpotImplCopyWith<$Res> {
  __$$LocalSpotImplCopyWithImpl(
    _$LocalSpotImpl _value,
    $Res Function(_$LocalSpotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalSpot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? walkingMinutes = null,
    Object? petFriendly = null,
  }) {
    return _then(
      _$LocalSpotImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        walkingMinutes: null == walkingMinutes
            ? _value.walkingMinutes
            : walkingMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        petFriendly: null == petFriendly
            ? _value.petFriendly
            : petFriendly // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalSpotImpl implements _LocalSpot {
  const _$LocalSpotImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.summary,
    required this.imageUrl,
    required this.walkingMinutes,
    this.petFriendly = false,
  });

  factory _$LocalSpotImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalSpotImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String summary;
  @override
  final String imageUrl;
  @override
  final int walkingMinutes;
  @override
  @JsonKey()
  final bool petFriendly;

  @override
  String toString() {
    return 'LocalSpot(id: $id, name: $name, type: $type, summary: $summary, imageUrl: $imageUrl, walkingMinutes: $walkingMinutes, petFriendly: $petFriendly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalSpotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.walkingMinutes, walkingMinutes) ||
                other.walkingMinutes == walkingMinutes) &&
            (identical(other.petFriendly, petFriendly) ||
                other.petFriendly == petFriendly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    summary,
    imageUrl,
    walkingMinutes,
    petFriendly,
  );

  /// Create a copy of LocalSpot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalSpotImplCopyWith<_$LocalSpotImpl> get copyWith =>
      __$$LocalSpotImplCopyWithImpl<_$LocalSpotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalSpotImplToJson(this);
  }
}

abstract class _LocalSpot implements LocalSpot {
  const factory _LocalSpot({
    required final String id,
    required final String name,
    required final String type,
    required final String summary,
    required final String imageUrl,
    required final int walkingMinutes,
    final bool petFriendly,
  }) = _$LocalSpotImpl;

  factory _LocalSpot.fromJson(Map<String, dynamic> json) =
      _$LocalSpotImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get summary;
  @override
  String get imageUrl;
  @override
  int get walkingMinutes;
  @override
  bool get petFriendly;

  /// Create a copy of LocalSpot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalSpotImplCopyWith<_$LocalSpotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotDetail _$SpotDetailFromJson(Map<String, dynamic> json) {
  return _SpotDetail.fromJson(json);
}

/// @nodoc
mixin _$SpotDetail {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get intro => throw _privateConstructorUsedError;
  String get heroImageUrl => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String get nightHighlight => throw _privateConstructorUsedError;
  String get photoTip => throw _privateConstructorUsedError;
  String get romanticMoment => throw _privateConstructorUsedError;
  String get missionPrompt => throw _privateConstructorUsedError;
  int get missionRadiusM => throw _privateConstructorUsedError;
  List<LocalSpot> get nearbySpots => throw _privateConstructorUsedError;
  String get petPolicy => throw _privateConstructorUsedError;
  String get petNote => throw _privateConstructorUsedError;

  /// Serializes this SpotDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotDetailCopyWith<SpotDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotDetailCopyWith<$Res> {
  factory $SpotDetailCopyWith(
    SpotDetail value,
    $Res Function(SpotDetail) then,
  ) = _$SpotDetailCopyWithImpl<$Res, SpotDetail>;
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String intro,
    String heroImageUrl,
    double lat,
    double lng,
    String nightHighlight,
    String photoTip,
    String romanticMoment,
    String missionPrompt,
    int missionRadiusM,
    List<LocalSpot> nearbySpots,
    String petPolicy,
    String petNote,
  });
}

/// @nodoc
class _$SpotDetailCopyWithImpl<$Res, $Val extends SpotDetail>
    implements $SpotDetailCopyWith<$Res> {
  _$SpotDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? intro = null,
    Object? heroImageUrl = null,
    Object? lat = null,
    Object? lng = null,
    Object? nightHighlight = null,
    Object? photoTip = null,
    Object? romanticMoment = null,
    Object? missionPrompt = null,
    Object? missionRadiusM = null,
    Object? nearbySpots = null,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            intro: null == intro
                ? _value.intro
                : intro // ignore: cast_nullable_to_non_nullable
                      as String,
            heroImageUrl: null == heroImageUrl
                ? _value.heroImageUrl
                : heroImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            nightHighlight: null == nightHighlight
                ? _value.nightHighlight
                : nightHighlight // ignore: cast_nullable_to_non_nullable
                      as String,
            photoTip: null == photoTip
                ? _value.photoTip
                : photoTip // ignore: cast_nullable_to_non_nullable
                      as String,
            romanticMoment: null == romanticMoment
                ? _value.romanticMoment
                : romanticMoment // ignore: cast_nullable_to_non_nullable
                      as String,
            missionPrompt: null == missionPrompt
                ? _value.missionPrompt
                : missionPrompt // ignore: cast_nullable_to_non_nullable
                      as String,
            missionRadiusM: null == missionRadiusM
                ? _value.missionRadiusM
                : missionRadiusM // ignore: cast_nullable_to_non_nullable
                      as int,
            nearbySpots: null == nearbySpots
                ? _value.nearbySpots
                : nearbySpots // ignore: cast_nullable_to_non_nullable
                      as List<LocalSpot>,
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
abstract class _$$SpotDetailImplCopyWith<$Res>
    implements $SpotDetailCopyWith<$Res> {
  factory _$$SpotDetailImplCopyWith(
    _$SpotDetailImpl value,
    $Res Function(_$SpotDetailImpl) then,
  ) = __$$SpotDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String intro,
    String heroImageUrl,
    double lat,
    double lng,
    String nightHighlight,
    String photoTip,
    String romanticMoment,
    String missionPrompt,
    int missionRadiusM,
    List<LocalSpot> nearbySpots,
    String petPolicy,
    String petNote,
  });
}

/// @nodoc
class __$$SpotDetailImplCopyWithImpl<$Res>
    extends _$SpotDetailCopyWithImpl<$Res, _$SpotDetailImpl>
    implements _$$SpotDetailImplCopyWith<$Res> {
  __$$SpotDetailImplCopyWithImpl(
    _$SpotDetailImpl _value,
    $Res Function(_$SpotDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpotDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? intro = null,
    Object? heroImageUrl = null,
    Object? lat = null,
    Object? lng = null,
    Object? nightHighlight = null,
    Object? photoTip = null,
    Object? romanticMoment = null,
    Object? missionPrompt = null,
    Object? missionRadiusM = null,
    Object? nearbySpots = null,
    Object? petPolicy = null,
    Object? petNote = null,
  }) {
    return _then(
      _$SpotDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        intro: null == intro
            ? _value.intro
            : intro // ignore: cast_nullable_to_non_nullable
                  as String,
        heroImageUrl: null == heroImageUrl
            ? _value.heroImageUrl
            : heroImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        nightHighlight: null == nightHighlight
            ? _value.nightHighlight
            : nightHighlight // ignore: cast_nullable_to_non_nullable
                  as String,
        photoTip: null == photoTip
            ? _value.photoTip
            : photoTip // ignore: cast_nullable_to_non_nullable
                  as String,
        romanticMoment: null == romanticMoment
            ? _value.romanticMoment
            : romanticMoment // ignore: cast_nullable_to_non_nullable
                  as String,
        missionPrompt: null == missionPrompt
            ? _value.missionPrompt
            : missionPrompt // ignore: cast_nullable_to_non_nullable
                  as String,
        missionRadiusM: null == missionRadiusM
            ? _value.missionRadiusM
            : missionRadiusM // ignore: cast_nullable_to_non_nullable
                  as int,
        nearbySpots: null == nearbySpots
            ? _value._nearbySpots
            : nearbySpots // ignore: cast_nullable_to_non_nullable
                  as List<LocalSpot>,
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
class _$SpotDetailImpl implements _SpotDetail {
  const _$SpotDetailImpl({
    required this.id,
    required this.name,
    required this.category,
    required this.intro,
    required this.heroImageUrl,
    required this.lat,
    required this.lng,
    required this.nightHighlight,
    required this.photoTip,
    required this.romanticMoment,
    required this.missionPrompt,
    required this.missionRadiusM,
    required final List<LocalSpot> nearbySpots,
    this.petPolicy = 'partial',
    this.petNote = '',
  }) : _nearbySpots = nearbySpots;

  factory _$SpotDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String intro;
  @override
  final String heroImageUrl;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String nightHighlight;
  @override
  final String photoTip;
  @override
  final String romanticMoment;
  @override
  final String missionPrompt;
  @override
  final int missionRadiusM;
  final List<LocalSpot> _nearbySpots;
  @override
  List<LocalSpot> get nearbySpots {
    if (_nearbySpots is EqualUnmodifiableListView) return _nearbySpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearbySpots);
  }

  @override
  @JsonKey()
  final String petPolicy;
  @override
  @JsonKey()
  final String petNote;

  @override
  String toString() {
    return 'SpotDetail(id: $id, name: $name, category: $category, intro: $intro, heroImageUrl: $heroImageUrl, lat: $lat, lng: $lng, nightHighlight: $nightHighlight, photoTip: $photoTip, romanticMoment: $romanticMoment, missionPrompt: $missionPrompt, missionRadiusM: $missionRadiusM, nearbySpots: $nearbySpots, petPolicy: $petPolicy, petNote: $petNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.intro, intro) || other.intro == intro) &&
            (identical(other.heroImageUrl, heroImageUrl) ||
                other.heroImageUrl == heroImageUrl) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.nightHighlight, nightHighlight) ||
                other.nightHighlight == nightHighlight) &&
            (identical(other.photoTip, photoTip) ||
                other.photoTip == photoTip) &&
            (identical(other.romanticMoment, romanticMoment) ||
                other.romanticMoment == romanticMoment) &&
            (identical(other.missionPrompt, missionPrompt) ||
                other.missionPrompt == missionPrompt) &&
            (identical(other.missionRadiusM, missionRadiusM) ||
                other.missionRadiusM == missionRadiusM) &&
            const DeepCollectionEquality().equals(
              other._nearbySpots,
              _nearbySpots,
            ) &&
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
    category,
    intro,
    heroImageUrl,
    lat,
    lng,
    nightHighlight,
    photoTip,
    romanticMoment,
    missionPrompt,
    missionRadiusM,
    const DeepCollectionEquality().hash(_nearbySpots),
    petPolicy,
    petNote,
  );

  /// Create a copy of SpotDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotDetailImplCopyWith<_$SpotDetailImpl> get copyWith =>
      __$$SpotDetailImplCopyWithImpl<_$SpotDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotDetailImplToJson(this);
  }
}

abstract class _SpotDetail implements SpotDetail {
  const factory _SpotDetail({
    required final String id,
    required final String name,
    required final String category,
    required final String intro,
    required final String heroImageUrl,
    required final double lat,
    required final double lng,
    required final String nightHighlight,
    required final String photoTip,
    required final String romanticMoment,
    required final String missionPrompt,
    required final int missionRadiusM,
    required final List<LocalSpot> nearbySpots,
    final String petPolicy,
    final String petNote,
  }) = _$SpotDetailImpl;

  factory _SpotDetail.fromJson(Map<String, dynamic> json) =
      _$SpotDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get intro;
  @override
  String get heroImageUrl;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String get nightHighlight;
  @override
  String get photoTip;
  @override
  String get romanticMoment;
  @override
  String get missionPrompt;
  @override
  int get missionRadiusM;
  @override
  List<LocalSpot> get nearbySpots;
  @override
  String get petPolicy;
  @override
  String get petNote;

  /// Create a copy of SpotDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotDetailImplCopyWith<_$SpotDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
