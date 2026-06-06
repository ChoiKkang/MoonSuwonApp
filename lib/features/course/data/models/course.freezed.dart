// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseSummary _$CourseSummaryFromJson(Map<String, dynamic> json) {
  return _CourseSummary.fromJson(json);
}

/// @nodoc
mixin _$CourseSummary {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  int get estimatedDurationMin => throw _privateConstructorUsedError;
  double get walkingDistanceKm => throw _privateConstructorUsedError;
  String get recommendedStartTime => throw _privateConstructorUsedError;
  int get spotCount => throw _privateConstructorUsedError;
  String get heroImageUrl => throw _privateConstructorUsedError;
  List<String> get themeTags => throw _privateConstructorUsedError;
  bool get petReadyFlag => throw _privateConstructorUsedError;

  /// Serializes this CourseSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseSummaryCopyWith<CourseSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseSummaryCopyWith<$Res> {
  factory $CourseSummaryCopyWith(
    CourseSummary value,
    $Res Function(CourseSummary) then,
  ) = _$CourseSummaryCopyWithImpl<$Res, CourseSummary>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    int estimatedDurationMin,
    double walkingDistanceKm,
    String recommendedStartTime,
    int spotCount,
    String heroImageUrl,
    List<String> themeTags,
    bool petReadyFlag,
  });
}

/// @nodoc
class _$CourseSummaryCopyWithImpl<$Res, $Val extends CourseSummary>
    implements $CourseSummaryCopyWith<$Res> {
  _$CourseSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? estimatedDurationMin = null,
    Object? walkingDistanceKm = null,
    Object? recommendedStartTime = null,
    Object? spotCount = null,
    Object? heroImageUrl = null,
    Object? themeTags = null,
    Object? petReadyFlag = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDurationMin: null == estimatedDurationMin
                ? _value.estimatedDurationMin
                : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            walkingDistanceKm: null == walkingDistanceKm
                ? _value.walkingDistanceKm
                : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            recommendedStartTime: null == recommendedStartTime
                ? _value.recommendedStartTime
                : recommendedStartTime // ignore: cast_nullable_to_non_nullable
                      as String,
            spotCount: null == spotCount
                ? _value.spotCount
                : spotCount // ignore: cast_nullable_to_non_nullable
                      as int,
            heroImageUrl: null == heroImageUrl
                ? _value.heroImageUrl
                : heroImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            themeTags: null == themeTags
                ? _value.themeTags
                : themeTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            petReadyFlag: null == petReadyFlag
                ? _value.petReadyFlag
                : petReadyFlag // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseSummaryImplCopyWith<$Res>
    implements $CourseSummaryCopyWith<$Res> {
  factory _$$CourseSummaryImplCopyWith(
    _$CourseSummaryImpl value,
    $Res Function(_$CourseSummaryImpl) then,
  ) = __$$CourseSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    int estimatedDurationMin,
    double walkingDistanceKm,
    String recommendedStartTime,
    int spotCount,
    String heroImageUrl,
    List<String> themeTags,
    bool petReadyFlag,
  });
}

/// @nodoc
class __$$CourseSummaryImplCopyWithImpl<$Res>
    extends _$CourseSummaryCopyWithImpl<$Res, _$CourseSummaryImpl>
    implements _$$CourseSummaryImplCopyWith<$Res> {
  __$$CourseSummaryImplCopyWithImpl(
    _$CourseSummaryImpl _value,
    $Res Function(_$CourseSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? estimatedDurationMin = null,
    Object? walkingDistanceKm = null,
    Object? recommendedStartTime = null,
    Object? spotCount = null,
    Object? heroImageUrl = null,
    Object? themeTags = null,
    Object? petReadyFlag = null,
  }) {
    return _then(
      _$CourseSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDurationMin: null == estimatedDurationMin
            ? _value.estimatedDurationMin
            : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        walkingDistanceKm: null == walkingDistanceKm
            ? _value.walkingDistanceKm
            : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        recommendedStartTime: null == recommendedStartTime
            ? _value.recommendedStartTime
            : recommendedStartTime // ignore: cast_nullable_to_non_nullable
                  as String,
        spotCount: null == spotCount
            ? _value.spotCount
            : spotCount // ignore: cast_nullable_to_non_nullable
                  as int,
        heroImageUrl: null == heroImageUrl
            ? _value.heroImageUrl
            : heroImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        themeTags: null == themeTags
            ? _value._themeTags
            : themeTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        petReadyFlag: null == petReadyFlag
            ? _value.petReadyFlag
            : petReadyFlag // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseSummaryImpl implements _CourseSummary {
  const _$CourseSummaryImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.estimatedDurationMin,
    required this.walkingDistanceKm,
    required this.recommendedStartTime,
    required this.spotCount,
    required this.heroImageUrl,
    required final List<String> themeTags,
    this.petReadyFlag = false,
  }) : _themeTags = themeTags;

  factory _$CourseSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final int estimatedDurationMin;
  @override
  final double walkingDistanceKm;
  @override
  final String recommendedStartTime;
  @override
  final int spotCount;
  @override
  final String heroImageUrl;
  final List<String> _themeTags;
  @override
  List<String> get themeTags {
    if (_themeTags is EqualUnmodifiableListView) return _themeTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themeTags);
  }

  @override
  @JsonKey()
  final bool petReadyFlag;

  @override
  String toString() {
    return 'CourseSummary(id: $id, title: $title, subtitle: $subtitle, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, spotCount: $spotCount, heroImageUrl: $heroImageUrl, themeTags: $themeTags, petReadyFlag: $petReadyFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.estimatedDurationMin, estimatedDurationMin) ||
                other.estimatedDurationMin == estimatedDurationMin) &&
            (identical(other.walkingDistanceKm, walkingDistanceKm) ||
                other.walkingDistanceKm == walkingDistanceKm) &&
            (identical(other.recommendedStartTime, recommendedStartTime) ||
                other.recommendedStartTime == recommendedStartTime) &&
            (identical(other.spotCount, spotCount) ||
                other.spotCount == spotCount) &&
            (identical(other.heroImageUrl, heroImageUrl) ||
                other.heroImageUrl == heroImageUrl) &&
            const DeepCollectionEquality().equals(
              other._themeTags,
              _themeTags,
            ) &&
            (identical(other.petReadyFlag, petReadyFlag) ||
                other.petReadyFlag == petReadyFlag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    estimatedDurationMin,
    walkingDistanceKm,
    recommendedStartTime,
    spotCount,
    heroImageUrl,
    const DeepCollectionEquality().hash(_themeTags),
    petReadyFlag,
  );

  /// Create a copy of CourseSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseSummaryImplCopyWith<_$CourseSummaryImpl> get copyWith =>
      __$$CourseSummaryImplCopyWithImpl<_$CourseSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseSummaryImplToJson(this);
  }
}

abstract class _CourseSummary implements CourseSummary {
  const factory _CourseSummary({
    required final String id,
    required final String title,
    required final String subtitle,
    required final int estimatedDurationMin,
    required final double walkingDistanceKm,
    required final String recommendedStartTime,
    required final int spotCount,
    required final String heroImageUrl,
    required final List<String> themeTags,
    final bool petReadyFlag,
  }) = _$CourseSummaryImpl;

  factory _CourseSummary.fromJson(Map<String, dynamic> json) =
      _$CourseSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  int get estimatedDurationMin;
  @override
  double get walkingDistanceKm;
  @override
  String get recommendedStartTime;
  @override
  int get spotCount;
  @override
  String get heroImageUrl;
  @override
  List<String> get themeTags;
  @override
  bool get petReadyFlag;

  /// Create a copy of CourseSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseSummaryImplCopyWith<_$CourseSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) {
  return _CourseDetail.fromJson(json);
}

/// @nodoc
mixin _$CourseDetail {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get estimatedDurationMin => throw _privateConstructorUsedError;
  double get walkingDistanceKm => throw _privateConstructorUsedError;
  String get recommendedStartTime => throw _privateConstructorUsedError;
  String get heroImageUrl => throw _privateConstructorUsedError;
  List<String> get themeTags => throw _privateConstructorUsedError;
  List<Spot> get spots => throw _privateConstructorUsedError;
  bool get petReadyFlag => throw _privateConstructorUsedError;

  /// Serializes this CourseDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseDetailCopyWith<CourseDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseDetailCopyWith<$Res> {
  factory $CourseDetailCopyWith(
    CourseDetail value,
    $Res Function(CourseDetail) then,
  ) = _$CourseDetailCopyWithImpl<$Res, CourseDetail>;
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    int estimatedDurationMin,
    double walkingDistanceKm,
    String recommendedStartTime,
    String heroImageUrl,
    List<String> themeTags,
    List<Spot> spots,
    bool petReadyFlag,
  });
}

/// @nodoc
class _$CourseDetailCopyWithImpl<$Res, $Val extends CourseDetail>
    implements $CourseDetailCopyWith<$Res> {
  _$CourseDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? estimatedDurationMin = null,
    Object? walkingDistanceKm = null,
    Object? recommendedStartTime = null,
    Object? heroImageUrl = null,
    Object? themeTags = null,
    Object? spots = null,
    Object? petReadyFlag = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDurationMin: null == estimatedDurationMin
                ? _value.estimatedDurationMin
                : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            walkingDistanceKm: null == walkingDistanceKm
                ? _value.walkingDistanceKm
                : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            recommendedStartTime: null == recommendedStartTime
                ? _value.recommendedStartTime
                : recommendedStartTime // ignore: cast_nullable_to_non_nullable
                      as String,
            heroImageUrl: null == heroImageUrl
                ? _value.heroImageUrl
                : heroImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            themeTags: null == themeTags
                ? _value.themeTags
                : themeTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            spots: null == spots
                ? _value.spots
                : spots // ignore: cast_nullable_to_non_nullable
                      as List<Spot>,
            petReadyFlag: null == petReadyFlag
                ? _value.petReadyFlag
                : petReadyFlag // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseDetailImplCopyWith<$Res>
    implements $CourseDetailCopyWith<$Res> {
  factory _$$CourseDetailImplCopyWith(
    _$CourseDetailImpl value,
    $Res Function(_$CourseDetailImpl) then,
  ) = __$$CourseDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String subtitle,
    String description,
    int estimatedDurationMin,
    double walkingDistanceKm,
    String recommendedStartTime,
    String heroImageUrl,
    List<String> themeTags,
    List<Spot> spots,
    bool petReadyFlag,
  });
}

/// @nodoc
class __$$CourseDetailImplCopyWithImpl<$Res>
    extends _$CourseDetailCopyWithImpl<$Res, _$CourseDetailImpl>
    implements _$$CourseDetailImplCopyWith<$Res> {
  __$$CourseDetailImplCopyWithImpl(
    _$CourseDetailImpl _value,
    $Res Function(_$CourseDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? description = null,
    Object? estimatedDurationMin = null,
    Object? walkingDistanceKm = null,
    Object? recommendedStartTime = null,
    Object? heroImageUrl = null,
    Object? themeTags = null,
    Object? spots = null,
    Object? petReadyFlag = null,
  }) {
    return _then(
      _$CourseDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDurationMin: null == estimatedDurationMin
            ? _value.estimatedDurationMin
            : estimatedDurationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        walkingDistanceKm: null == walkingDistanceKm
            ? _value.walkingDistanceKm
            : walkingDistanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        recommendedStartTime: null == recommendedStartTime
            ? _value.recommendedStartTime
            : recommendedStartTime // ignore: cast_nullable_to_non_nullable
                  as String,
        heroImageUrl: null == heroImageUrl
            ? _value.heroImageUrl
            : heroImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        themeTags: null == themeTags
            ? _value._themeTags
            : themeTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        spots: null == spots
            ? _value._spots
            : spots // ignore: cast_nullable_to_non_nullable
                  as List<Spot>,
        petReadyFlag: null == petReadyFlag
            ? _value.petReadyFlag
            : petReadyFlag // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseDetailImpl implements _CourseDetail {
  const _$CourseDetailImpl({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.estimatedDurationMin,
    required this.walkingDistanceKm,
    required this.recommendedStartTime,
    required this.heroImageUrl,
    required final List<String> themeTags,
    required final List<Spot> spots,
    this.petReadyFlag = false,
  }) : _themeTags = themeTags,
       _spots = spots;

  factory _$CourseDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String description;
  @override
  final int estimatedDurationMin;
  @override
  final double walkingDistanceKm;
  @override
  final String recommendedStartTime;
  @override
  final String heroImageUrl;
  final List<String> _themeTags;
  @override
  List<String> get themeTags {
    if (_themeTags is EqualUnmodifiableListView) return _themeTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themeTags);
  }

  final List<Spot> _spots;
  @override
  List<Spot> get spots {
    if (_spots is EqualUnmodifiableListView) return _spots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spots);
  }

  @override
  @JsonKey()
  final bool petReadyFlag;

  @override
  String toString() {
    return 'CourseDetail(id: $id, title: $title, subtitle: $subtitle, description: $description, estimatedDurationMin: $estimatedDurationMin, walkingDistanceKm: $walkingDistanceKm, recommendedStartTime: $recommendedStartTime, heroImageUrl: $heroImageUrl, themeTags: $themeTags, spots: $spots, petReadyFlag: $petReadyFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.estimatedDurationMin, estimatedDurationMin) ||
                other.estimatedDurationMin == estimatedDurationMin) &&
            (identical(other.walkingDistanceKm, walkingDistanceKm) ||
                other.walkingDistanceKm == walkingDistanceKm) &&
            (identical(other.recommendedStartTime, recommendedStartTime) ||
                other.recommendedStartTime == recommendedStartTime) &&
            (identical(other.heroImageUrl, heroImageUrl) ||
                other.heroImageUrl == heroImageUrl) &&
            const DeepCollectionEquality().equals(
              other._themeTags,
              _themeTags,
            ) &&
            const DeepCollectionEquality().equals(other._spots, _spots) &&
            (identical(other.petReadyFlag, petReadyFlag) ||
                other.petReadyFlag == petReadyFlag));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    description,
    estimatedDurationMin,
    walkingDistanceKm,
    recommendedStartTime,
    heroImageUrl,
    const DeepCollectionEquality().hash(_themeTags),
    const DeepCollectionEquality().hash(_spots),
    petReadyFlag,
  );

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailImplCopyWith<_$CourseDetailImpl> get copyWith =>
      __$$CourseDetailImplCopyWithImpl<_$CourseDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseDetailImplToJson(this);
  }
}

abstract class _CourseDetail implements CourseDetail {
  const factory _CourseDetail({
    required final String id,
    required final String title,
    required final String subtitle,
    required final String description,
    required final int estimatedDurationMin,
    required final double walkingDistanceKm,
    required final String recommendedStartTime,
    required final String heroImageUrl,
    required final List<String> themeTags,
    required final List<Spot> spots,
    final bool petReadyFlag,
  }) = _$CourseDetailImpl;

  factory _CourseDetail.fromJson(Map<String, dynamic> json) =
      _$CourseDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get description;
  @override
  int get estimatedDurationMin;
  @override
  double get walkingDistanceKm;
  @override
  String get recommendedStartTime;
  @override
  String get heroImageUrl;
  @override
  List<String> get themeTags;
  @override
  List<Spot> get spots;
  @override
  bool get petReadyFlag;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailImplCopyWith<_$CourseDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
