// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_history_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userCourseHistory)
final userCourseHistoryProvider = UserCourseHistoryProvider._();

final class UserCourseHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CourseHistoryEntryDto>>,
          List<CourseHistoryEntryDto>,
          FutureOr<List<CourseHistoryEntryDto>>
        >
    with
        $FutureModifier<List<CourseHistoryEntryDto>>,
        $FutureProvider<List<CourseHistoryEntryDto>> {
  UserCourseHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCourseHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCourseHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<CourseHistoryEntryDto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CourseHistoryEntryDto>> create(Ref ref) {
    return userCourseHistory(ref);
  }
}

String _$userCourseHistoryHash() => r'0000000000000000000000000000000000000001';
