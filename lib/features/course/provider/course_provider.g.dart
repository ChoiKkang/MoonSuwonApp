// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(courseRepository)
final courseRepositoryProvider = CourseRepositoryProvider._();

final class CourseRepositoryProvider
    extends
        $FunctionalProvider<
          CourseRepository,
          CourseRepository,
          CourseRepository
        >
    with $Provider<CourseRepository> {
  CourseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseRepositoryHash();

  @$internal
  @override
  $ProviderElement<CourseRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CourseRepository create(Ref ref) {
    return courseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseRepository>(value),
    );
  }
}

String _$courseRepositoryHash() => r'613977cd53a340b70f24d7f1e4a3d1ad50732709';

@ProviderFor(courses)
final coursesProvider = CoursesProvider._();

final class CoursesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CourseSummary>>,
          List<CourseSummary>,
          FutureOr<List<CourseSummary>>
        >
    with
        $FutureModifier<List<CourseSummary>>,
        $FutureProvider<List<CourseSummary>> {
  CoursesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coursesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coursesHash();

  @$internal
  @override
  $FutureProviderElement<List<CourseSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CourseSummary>> create(Ref ref) {
    return courses(ref);
  }
}

String _$coursesHash() => r'861f8f0e9eeea667abe406327bd13edd1498f969';

@ProviderFor(courseDetail)
final courseDetailProvider = CourseDetailFamily._();

final class CourseDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<CourseDetail>,
          CourseDetail,
          FutureOr<CourseDetail>
        >
    with $FutureModifier<CourseDetail>, $FutureProvider<CourseDetail> {
  CourseDetailProvider._({
    required CourseDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'courseDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$courseDetailHash();

  @override
  String toString() {
    return r'courseDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CourseDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CourseDetail> create(Ref ref) {
    final argument = this.argument as String;
    return courseDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$courseDetailHash() => r'b3e0baf4438fdfca2c6377c6224424e8da2a86bc';

final class CourseDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CourseDetail>, String> {
  CourseDetailFamily._()
    : super(
        retry: null,
        name: r'courseDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CourseDetailProvider call(String courseId) =>
      CourseDetailProvider._(argument: courseId, from: this);

  @override
  String toString() => r'courseDetailProvider';
}
