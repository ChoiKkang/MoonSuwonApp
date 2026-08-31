// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CourseProgressNotifier)
final courseProgressNotifierProvider = CourseProgressNotifierProvider._();

final class CourseProgressNotifierProvider
    extends $NotifierProvider<CourseProgressNotifier, CourseProgressState> {
  CourseProgressNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseProgressNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseProgressNotifierHash();

  @$internal
  @override
  CourseProgressNotifier create() => CourseProgressNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseProgressState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseProgressState>(value),
    );
  }
}

String _$courseProgressNotifierHash() =>
    r'fcb802862b02d1ab4de44d95d2c05eabf593b813';

abstract class _$CourseProgressNotifier extends $Notifier<CourseProgressState> {
  CourseProgressState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CourseProgressState, CourseProgressState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CourseProgressState, CourseProgressState>,
              CourseProgressState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ArrivalModalNotifier)
final arrivalModalNotifierProvider = ArrivalModalNotifierProvider._();

final class ArrivalModalNotifierProvider
    extends $NotifierProvider<ArrivalModalNotifier, bool> {
  ArrivalModalNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arrivalModalNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arrivalModalNotifierHash();

  @$internal
  @override
  ArrivalModalNotifier create() => ArrivalModalNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$arrivalModalNotifierHash() =>
    r'10f1e57b02cd0f74e720c43ca02ed8d64ebf11c1';

abstract class _$ArrivalModalNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
