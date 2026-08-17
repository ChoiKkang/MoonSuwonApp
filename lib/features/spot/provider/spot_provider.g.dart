// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$spotRepositoryHash() => r'0aa34cc31e5121f88f3f3d8bbe7404f13213b9f8';

/// See also [spotRepository].
@ProviderFor(spotRepository)
final spotRepositoryProvider = AutoDisposeProvider<SpotRepository>.internal(
  spotRepository,
  name: r'spotRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$spotRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpotRepositoryRef = AutoDisposeProviderRef<SpotRepository>;
String _$spotRepositorySupabaseHash() =>
    r'b2cd28ee4fdf587e4b1216f7844838a8f191299a';

/// See also [spotRepositorySupabase].
@ProviderFor(spotRepositorySupabase)
final spotRepositorySupabaseProvider =
    AutoDisposeProvider<SpotRepositorySupabase>.internal(
      spotRepositorySupabase,
      name: r'spotRepositorySupabaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$spotRepositorySupabaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpotRepositorySupabaseRef =
    AutoDisposeProviderRef<SpotRepositorySupabase>;
String _$spotDetailHash() => r'3d56fa6769358084bd83978679b437d518edbc24';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [spotDetail].
@ProviderFor(spotDetail)
const spotDetailProvider = SpotDetailFamily();

/// See also [spotDetail].
class SpotDetailFamily extends Family<AsyncValue<SpotDetail>> {
  /// See also [spotDetail].
  const SpotDetailFamily();

  /// See also [spotDetail].
  SpotDetailProvider call(String spotId) {
    return SpotDetailProvider(spotId);
  }

  @override
  SpotDetailProvider getProviderOverride(
    covariant SpotDetailProvider provider,
  ) {
    return call(provider.spotId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'spotDetailProvider';
}

/// See also [spotDetail].
class SpotDetailProvider extends AutoDisposeFutureProvider<SpotDetail> {
  /// See also [spotDetail].
  SpotDetailProvider(String spotId)
    : this._internal(
        (ref) => spotDetail(ref as SpotDetailRef, spotId),
        from: spotDetailProvider,
        name: r'spotDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$spotDetailHash,
        dependencies: SpotDetailFamily._dependencies,
        allTransitiveDependencies: SpotDetailFamily._allTransitiveDependencies,
        spotId: spotId,
      );

  SpotDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.spotId,
  }) : super.internal();

  final String spotId;

  @override
  Override overrideWith(
    FutureOr<SpotDetail> Function(SpotDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpotDetailProvider._internal(
        (ref) => create(ref as SpotDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        spotId: spotId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SpotDetail> createElement() {
    return _SpotDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotDetailProvider && other.spotId == spotId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, spotId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SpotDetailRef on AutoDisposeFutureProviderRef<SpotDetail> {
  /// The parameter `spotId` of this provider.
  String get spotId;
}

class _SpotDetailProviderElement
    extends AutoDisposeFutureProviderElement<SpotDetail>
    with SpotDetailRef {
  _SpotDetailProviderElement(super.provider);

  @override
  String get spotId => (origin as SpotDetailProvider).spotId;
}

String _$nowGoodSpotsHash() => r'b1430fcf24e036eb5494996908b7474073033d6f';

/// See also [nowGoodSpots].
@ProviderFor(nowGoodSpots)
final nowGoodSpotsProvider =
    AutoDisposeFutureProvider<List<SpotSummary>>.internal(
      nowGoodSpots,
      name: r'nowGoodSpotsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$nowGoodSpotsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NowGoodSpotsRef = AutoDisposeFutureProviderRef<List<SpotSummary>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
