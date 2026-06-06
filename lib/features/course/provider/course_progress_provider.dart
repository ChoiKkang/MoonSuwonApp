import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/course/data/models/spot.dart' show SpotProgressStatus;

part 'course_progress_provider.g.dart';

@riverpod
class CourseProgressNotifier extends _$CourseProgressNotifier {
  @override
  int build() => 0;

  void completeCurrentSpot() {
    state = state + 1;
  }

  void reset() {
    state = 0;
  }
}

@riverpod
class ArrivalModalNotifier extends _$ArrivalModalNotifier {
  @override
  bool build() => false;

  void show() => state = true;
  void hide() => state = false;
}

SpotProgressStatus statusForIndex(int currentIndex, int spotIndex) {
  if (spotIndex < currentIndex) return SpotProgressStatus.completed;
  if (spotIndex == currentIndex) return SpotProgressStatus.current;
  return SpotProgressStatus.pending;
}
