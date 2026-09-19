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
import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts;
import 'package:dalbit_suwon/features/spot/data/models/audio_story.dart'
    show AudioStory;
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
    // 반려동물/접근성/오디오 섹션도 데이터가 없으면 감춘다.
    expect(find.text('반려동물 동반'), findsNothing);
    expect(find.text('편의시설과 접근성'), findsNothing);
    expect(find.text('오디오 해설'), findsNothing);
  });

  testWidgets('renders pet, accessibility and audio sections when present', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 3000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    const richDetail = SpotDetail(
      id: 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
      name: '방화수류정',
      category: 'heritage',
      intro: '수원화성 야경의 꽃, 방화수류정입니다.',
      heroImageUrl: 'https://example.com/banghwa-hero.jpg',
      lat: 37.2870,
      lng: 127.0175,
      nightHighlight: '',
      photoTip: '',
      romanticMoment: '',
      missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
      missionRadiusM: 80,
      petPolicy: 'allowed',
      petNote: '리드줄을 채우면 성곽 산책로에 동반할 수 있어요.',
      accessibility: AccessibilityFacts(
        parking: '화홍문 공영주차장 이용 후 도보 5분.',
        restroom: '용연 공중화장실 이용 가능.',
      ),
      audioStories: [
        AudioStory(
          id: 'odii-banghwa-01',
          audioTitle: '방화수류정 해설',
          script: '방화수류정은 1794년에 세운 수원화성의 동북각루입니다.',
        ),
      ],
      nearbySpots: [],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          spotDetailProvider(
            'banghwasuryujeong',
          ).overrideWith((ref) async => richDetail),
          favoriteRepositoryProvider.overrideWithValue(
            _FakeFavoriteRepository(),
          ),
        ],
        child: const MaterialApp(
          home: SpotDetailPage(spotId: 'banghwasuryujeong'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('반려동물 동반'), findsOneWidget);
    expect(find.text('동반 가능'), findsOneWidget);
    expect(find.text('편의시설과 접근성'), findsOneWidget);
    expect(find.text('현장 편의'), findsOneWidget);
    expect(find.text('오디오 해설'), findsOneWidget);
    expect(find.text('방화수류정 해설'), findsOneWidget);
  });
}
