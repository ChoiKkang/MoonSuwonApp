// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myPageRepository)
final myPageRepositoryProvider = MyPageRepositoryProvider._();

final class MyPageRepositoryProvider
    extends
        $FunctionalProvider<
          MyPageRepository,
          MyPageRepository,
          MyPageRepository
        >
    with $Provider<MyPageRepository> {
  MyPageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPageRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPageRepositoryHash();

  @$internal
  @override
  $ProviderElement<MyPageRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MyPageRepository create(Ref ref) {
    return myPageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyPageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyPageRepository>(value),
    );
  }
}

String _$myPageRepositoryHash() => r'e2f1fd706884bd4e87cb4914b4d5462950f6b97a';

@ProviderFor(myPageSummary)
final myPageSummaryProvider = MyPageSummaryProvider._();

final class MyPageSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<MyPageSummary>,
          MyPageSummary,
          FutureOr<MyPageSummary>
        >
    with $FutureModifier<MyPageSummary>, $FutureProvider<MyPageSummary> {
  MyPageSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPageSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPageSummaryHash();

  @$internal
  @override
  $FutureProviderElement<MyPageSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MyPageSummary> create(Ref ref) {
    return myPageSummary(ref);
  }
}

String _$myPageSummaryHash() => r'47ae6d3b9b6a2e7f8c1629ff9c176b8251b4d1fd';
