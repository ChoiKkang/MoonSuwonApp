import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/favorite/data/favorite_repository.dart'
    show FavoriteRepository, FavoriteTarget;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_course_summary.dart'
    show FavoriteCourseSummary;
import 'package:dalbit_suwon/features/favorite/data/models/favorite_spot_summary.dart'
    show FavoriteSpotSummary;
import 'package:dalbit_suwon/features/favorite/provider/favorite_provider.dart'
    show favoriteRepositoryProvider;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart'
    show spotDetailProvider;
import 'package:dalbit_suwon/features/spot/ui/spot_detail_page.dart'
    show SpotDetailPage;

/// FavoriteToggleButton이 provider를 watch하므로 테스트 격리를 위해 최소 fake 저장소.
class _FakeFavoriteRepository implements FavoriteRepository {
  @override
  Future<List<FavoriteSpotSummary>> fetchFavoriteSpotsAsync() async =>
      const [];

  @override
  Future<List<FavoriteCourseSummary>> fetchFavoriteCoursesAsync() async =>
      const [];

  @override
  Future<void> addSpotAsync(FavoriteSpotSummary spot) async {}

  @override
  Future<void> addCourseAsync(FavoriteCourseSummary course) async {}

  @override
  Future<void> removeAsync(FavoriteTarget target) async {}
}

void main() {
  testWidgets('hides empty live editorial sections from the spot detail page', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const sparseDetail = SpotDetail(
      id: 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
      name: '효원의 종·서장대',
      category: 'heritage',
      intro: '수원화성의 야경을 만나는 서장대입니다.',
      heroImageUrl: 'https://example.com/seojangdae-hero.jpg',
      lat: 37.2865,
      lng: 127.0101,
      nightHighlight: '',
      photoTip: '',
      romanticMoment: '',
      missionPrompt: '서장대의 야경을 사진으로 남겨보세요.',
      missionRadiusM: 80,
      nearbySpots: [],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          spotDetailProvider(
            'seojangdae',
          ).overrideWith((ref) async => sparseDetail),
          favoriteRepositoryProvider.overrideWithValue(
            _FakeFavoriteRepository(),
          ),
        ],
        child: const MaterialApp(home: SpotDetailPage(spotId: 'seojangdae')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Night Highlights'), findsNothing);
    expect(find.text('Photo Tip'), findsNothing);
    expect(find.text('낭만적인 순간'), findsNothing);
  });
}
