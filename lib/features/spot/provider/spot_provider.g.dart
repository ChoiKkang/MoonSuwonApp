// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotRepository)
final spotRepositoryProvider = SpotRepositoryProvider._();

final class SpotRepositoryProvider
    extends $FunctionalProvider<SpotRepository, SpotRepository, SpotRepository>
    with $Provider<SpotRepository> {
  SpotRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotRepositoryHash();

  @$internal
  @override
  $ProviderElement<SpotRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotRepository create(Ref ref) {
    return spotRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotRepository>(value),
    );
  }
}

String _$spotRepositoryHash() => r'0aa34cc31e5121f88f3f3d8bbe7404f13213b9f8';

@ProviderFor(spotRepositorySupabase)
final spotRepositorySupabaseProvider = SpotRepositorySupabaseProvider._();

final class SpotRepositorySupabaseProvider
    extends
        $FunctionalProvider<
          SpotRepositorySupabase,
          SpotRepositorySupabase,
          SpotRepositorySupabase
        >
    with $Provider<SpotRepositorySupabase> {
  SpotRepositorySupabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotRepositorySupabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotRepositorySupabaseHash();

  @$internal
  @override
  $ProviderElement<SpotRepositorySupabase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SpotRepositorySupabase create(Ref ref) {
    return spotRepositorySupabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotRepositorySupabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotRepositorySupabase>(value),
    );
  }
}

String _$spotRepositorySupabaseHash() =>
    r'b2cd28ee4fdf587e4b1216f7844838a8f191299a';

@ProviderFor(spotDetail)
final spotDetailProvider = SpotDetailFamily._();

final class SpotDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotDetail>,
          SpotDetail,
          FutureOr<SpotDetail>
        >
    with $FutureModifier<SpotDetail>, $FutureProvider<SpotDetail> {
  SpotDetailProvider._({
    required SpotDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'spotDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotDetailHash();

  @override
  String toString() {
    return r'spotDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SpotDetail> create(Ref ref) {
    final argument = this.argument as String;
    return spotDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotDetailHash() => r'3d56fa6769358084bd83978679b437d518edbc24';

final class SpotDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotDetail>, String> {
  SpotDetailFamily._()
    : super(
        retry: null,
        name: r'spotDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SpotDetailProvider call(String spotId) =>
      SpotDetailProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotDetailProvider';
}

@ProviderFor(nowGoodSpots)
final nowGoodSpotsProvider = NowGoodSpotsProvider._();

final class NowGoodSpotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotSummary>>,
          List<SpotSummary>,
          FutureOr<List<SpotSummary>>
        >
    with
        $FutureModifier<List<SpotSummary>>,
        $FutureProvider<List<SpotSummary>> {
  NowGoodSpotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowGoodSpotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowGoodSpotsHash();

  @$internal
  @override
  $FutureProviderElement<List<SpotSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotSummary>> create(Ref ref) {
    return nowGoodSpots(ref);
  }
}

String _$nowGoodSpotsHash() => r'b1430fcf24e036eb5494996908b7474073033d6f';
