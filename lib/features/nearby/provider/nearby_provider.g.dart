// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// '내 주변' 데이터 소스. 기본은 Supabase 구현체.
///
/// 테스트나 Mock 데모에서는 [NearbyRepositoryMock]으로
/// `overrideWithValue` 해서 교체한다.

@ProviderFor(nearbyRepository)
final nearbyRepositoryProvider = NearbyRepositoryProvider._();

/// '내 주변' 데이터 소스. 기본은 Supabase 구현체.
///
/// 테스트나 Mock 데모에서는 [NearbyRepositoryMock]으로
/// `overrideWithValue` 해서 교체한다.

final class NearbyRepositoryProvider
    extends
        $FunctionalProvider<
          NearbyRepository,
          NearbyRepository,
          NearbyRepository
        >
    with $Provider<NearbyRepository> {
  /// '내 주변' 데이터 소스. 기본은 Supabase 구현체.
  ///
  /// 테스트나 Mock 데모에서는 [NearbyRepositoryMock]으로
  /// `overrideWithValue` 해서 교체한다.
  NearbyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyRepositoryHash();

  @$internal
  @override
  $ProviderElement<NearbyRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NearbyRepository create(Ref ref) {
    return nearbyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NearbyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NearbyRepository>(value),
    );
  }
}

String _$nearbyRepositoryHash() => r'3334d9d7160241f0d3cf163605d02656d02575e0';

/// 검색 기준 좌표.
///
/// 위치 권한이 허용되어 현재 위치를 얻을 수 있으면 실제 좌표,
/// 아니면 [NearbySearchOrigin.fallback] (수원화성 대표 좌표)을 반환한다.

@ProviderFor(nearbySearchOrigin)
final nearbySearchOriginProvider = NearbySearchOriginProvider._();

/// 검색 기준 좌표.
///
/// 위치 권한이 허용되어 현재 위치를 얻을 수 있으면 실제 좌표,
/// 아니면 [NearbySearchOrigin.fallback] (수원화성 대표 좌표)을 반환한다.

final class NearbySearchOriginProvider
    extends
        $FunctionalProvider<
          AsyncValue<NearbySearchOrigin>,
          NearbySearchOrigin,
          FutureOr<NearbySearchOrigin>
        >
    with
        $FutureModifier<NearbySearchOrigin>,
        $FutureProvider<NearbySearchOrigin> {
  /// 검색 기준 좌표.
  ///
  /// 위치 권한이 허용되어 현재 위치를 얻을 수 있으면 실제 좌표,
  /// 아니면 [NearbySearchOrigin.fallback] (수원화성 대표 좌표)을 반환한다.
  NearbySearchOriginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbySearchOriginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbySearchOriginHash();

  @$internal
  @override
  $FutureProviderElement<NearbySearchOrigin> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NearbySearchOrigin> create(Ref ref) {
    return nearbySearchOrigin(ref);
  }
}

String _$nearbySearchOriginHash() =>
    r'e93124087a81d2f6369d5131dc8dfee02056d532';

/// 사용자가 UI에서 선택한 필터/정렬 상태.
///
/// 필터 바텀시트는 이 컨트롤러의 메서드를 호출하고, `nearbyPlacesProvider`가
/// 이 상태를 watch해서 필터 변화 시 자동으로 재조회한다.

@ProviderFor(NearbyFiltersController)
final nearbyFiltersControllerProvider = NearbyFiltersControllerProvider._();

/// 사용자가 UI에서 선택한 필터/정렬 상태.
///
/// 필터 바텀시트는 이 컨트롤러의 메서드를 호출하고, `nearbyPlacesProvider`가
/// 이 상태를 watch해서 필터 변화 시 자동으로 재조회한다.
final class NearbyFiltersControllerProvider
    extends $NotifierProvider<NearbyFiltersController, NearbyFilters> {
  /// 사용자가 UI에서 선택한 필터/정렬 상태.
  ///
  /// 필터 바텀시트는 이 컨트롤러의 메서드를 호출하고, `nearbyPlacesProvider`가
  /// 이 상태를 watch해서 필터 변화 시 자동으로 재조회한다.
  NearbyFiltersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyFiltersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyFiltersControllerHash();

  @$internal
  @override
  NearbyFiltersController create() => NearbyFiltersController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NearbyFilters value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NearbyFilters>(value),
    );
  }
}

String _$nearbyFiltersControllerHash() =>
    r'a25993db50da8d3c47e03c32025afbe0b2f603a6';

/// 사용자가 UI에서 선택한 필터/정렬 상태.
///
/// 필터 바텀시트는 이 컨트롤러의 메서드를 호출하고, `nearbyPlacesProvider`가
/// 이 상태를 watch해서 필터 변화 시 자동으로 재조회한다.

abstract class _$NearbyFiltersController extends $Notifier<NearbyFilters> {
  NearbyFilters build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NearbyFilters, NearbyFilters>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NearbyFilters, NearbyFilters>,
              NearbyFilters,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 검색 기준 좌표 + 사용자 필터를 조합해 반경 내 스팟을 조회한다.
///
/// [nearbySearchOriginProvider]와 [nearbyFiltersControllerProvider]를 watch하므로
/// 좌표나 필터가 갱신되면 자동으로 재조회한다.

@ProviderFor(nearbyPlaces)
final nearbyPlacesProvider = NearbyPlacesProvider._();

/// 검색 기준 좌표 + 사용자 필터를 조합해 반경 내 스팟을 조회한다.
///
/// [nearbySearchOriginProvider]와 [nearbyFiltersControllerProvider]를 watch하므로
/// 좌표나 필터가 갱신되면 자동으로 재조회한다.

final class NearbyPlacesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NearbyPlace>>,
          List<NearbyPlace>,
          FutureOr<List<NearbyPlace>>
        >
    with
        $FutureModifier<List<NearbyPlace>>,
        $FutureProvider<List<NearbyPlace>> {
  /// 검색 기준 좌표 + 사용자 필터를 조합해 반경 내 스팟을 조회한다.
  ///
  /// [nearbySearchOriginProvider]와 [nearbyFiltersControllerProvider]를 watch하므로
  /// 좌표나 필터가 갱신되면 자동으로 재조회한다.
  NearbyPlacesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyPlacesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyPlacesHash();

  @$internal
  @override
  $FutureProviderElement<List<NearbyPlace>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NearbyPlace>> create(Ref ref) {
    return nearbyPlaces(ref);
  }
}

String _$nearbyPlacesHash() => r'd9199798d215282f93be2ebda53881a5a0594e3c';
