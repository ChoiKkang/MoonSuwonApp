import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteTarget, FavoriteTargetType;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;
import 'package:dalbit_suwon/features/favorite/provider/favorite_provider.dart'
    show
        favoriteCoursesProvider,
        favoriteRepositoryProvider,
        favoriteSpotsProvider,
        favoriteTargetsProvider;
import 'package:dalbit_suwon/shared/widgets/glass_icon_button.dart'
    show GlassIconButton;

/// 스팟/코스 상세 페이지의 하트/북마크 토글 버튼.
///
/// - `FavoriteToggleButton.spot`: `Icons.favorite`/`Icons.favorite_outline`
/// - `FavoriteToggleButton.course`: `Icons.bookmark`/`Icons.bookmark_outline`
///
/// 상태는 `favoriteTargetsProvider`를 watch하고, 토글 시
/// `favoriteRepositoryProvider`로 저장 후 관련 provider를 invalidate 한다.
class FavoriteToggleButton extends ConsumerWidget {
  const FavoriteToggleButton.spot({super.key, required this.spot})
    : course = null;

  const FavoriteToggleButton.course({super.key, required this.course})
    : spot = null;

  final FavoriteSpotSummary? spot;
  final FavoriteCourseSummary? course;

  FavoriteTarget get _target => spot != null
      ? FavoriteTarget(type: FavoriteTargetType.spot, id: spot!.placeId)
      : FavoriteTarget(type: FavoriteTargetType.course, id: course!.courseId);

  IconData _iconFor({required bool active}) {
    if (spot != null) {
      return active ? Icons.favorite : Icons.favorite_outline;
    }
    return active ? Icons.bookmark : Icons.bookmark_outline;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetsAsync = ref.watch(favoriteTargetsProvider);
    final isFavorite = targetsAsync.value?.contains(_target) ?? false;
    final isLoading = targetsAsync.isLoading;

    return GlassIconButton(
      icon: _iconFor(active: isFavorite),
      color: isFavorite ? Colors.redAccent : null,
      onPressed: () => _onToggle(context, ref, isFavorite, isLoading),
    );
  }

  Future<void> _onToggle(
    BuildContext context,
    WidgetRef ref,
    bool isFavorite,
    bool isLoading,
  ) async {
    if (isLoading) return;
    final repository = ref.read(favoriteRepositoryProvider);
    try {
      if (isFavorite) {
        await repository.removeAsync(_target);
      } else if (spot != null) {
        await repository.addSpotAsync(spot!);
      } else {
        await repository.addCourseAsync(course!);
      }
      ref.invalidate(favoriteSpotsProvider);
      ref.invalidate(favoriteCoursesProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('찜 저장에 실패했어요. ($e)')),
        );
      }
    }
  }
}
