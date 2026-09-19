// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowd_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crowdForecastRepositoryMock)
final crowdForecastRepositoryMockProvider =
    CrowdForecastRepositoryMockProvider._();

final class CrowdForecastRepositoryMockProvider
    extends
        $FunctionalProvider<
          CrowdForecastRepository,
          CrowdForecastRepository,
          CrowdForecastRepository
        >
    with $Provider<CrowdForecastRepository> {
  CrowdForecastRepositoryMockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crowdForecastRepositoryMockProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crowdForecastRepositoryMockHash();

  @$internal
  @override
  $ProviderElement<CrowdForecastRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CrowdForecastRepository create(Ref ref) {
    return crowdForecastRepositoryMock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrowdForecastRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrowdForecastRepository>(value),
    );
  }
}

String _$crowdForecastRepositoryMockHash() =>
    r'bc033d5345dd3ce6886511e2b3793d2deecea0ab';

@ProviderFor(crowdForecastRepositorySupabase)
final crowdForecastRepositorySupabaseProvider =
    CrowdForecastRepositorySupabaseProvider._();

final class CrowdForecastRepositorySupabaseProvider
    extends
        $FunctionalProvider<
          CrowdForecastRepository,
          CrowdForecastRepository,
          CrowdForecastRepository
        >
    with $Provider<CrowdForecastRepository> {
  CrowdForecastRepositorySupabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crowdForecastRepositorySupabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crowdForecastRepositorySupabaseHash();

  @$internal
  @override
  $ProviderElement<CrowdForecastRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CrowdForecastRepository create(Ref ref) {
    return crowdForecastRepositorySupabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrowdForecastRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrowdForecastRepository>(value),
    );
  }
}

String _$crowdForecastRepositorySupabaseHash() =>
    r'3a527b3c55f07225b4d29e1d5a4a75a087624131';

/// 장소의 날짜별 예측 혼잡도.
///
/// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
/// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.

@ProviderFor(crowdForecast)
final crowdForecastProvider = CrowdForecastFamily._();

/// 장소의 날짜별 예측 혼잡도.
///
/// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
/// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.

final class CrowdForecastProvider
    extends
        $FunctionalProvider<
          AsyncValue<CrowdForecast>,
          CrowdForecast,
          FutureOr<CrowdForecast>
        >
    with $FutureModifier<CrowdForecast>, $FutureProvider<CrowdForecast> {
  /// 장소의 날짜별 예측 혼잡도.
  ///
  /// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
  /// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.
  CrowdForecastProvider._({
    required CrowdForecastFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'crowdForecastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$crowdForecastHash();

  @override
  String toString() {
    return r'crowdForecastProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CrowdForecast> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CrowdForecast> create(Ref ref) {
    final argument = this.argument as String;
    return crowdForecast(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CrowdForecastProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crowdForecastHash() => r'8d61f9dc33b370f0397883eb81a3f1ab6694e172';

/// 장소의 날짜별 예측 혼잡도.
///
/// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
/// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.

final class CrowdForecastFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CrowdForecast>, String> {
  CrowdForecastFamily._()
    : super(
        retry: null,
        name: r'crowdForecastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 장소의 날짜별 예측 혼잡도.
  ///
  /// Mock 스팟 id(`spot-` 접두어)는 로컬 데이터를, 그 외(UUID/slug)는 Supabase
  /// RPC를 사용한다. spotDetailProvider의 라우팅 규칙과 동일하다.

  CrowdForecastProvider call(String placeId) =>
      CrowdForecastProvider._(argument: placeId, from: this);

  @override
  String toString() => r'crowdForecastProvider';
}
