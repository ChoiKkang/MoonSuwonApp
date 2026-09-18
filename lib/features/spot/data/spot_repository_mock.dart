import 'package:dalbit_suwon/features/spot/data/spot_repository.dart'
    show NowGoodSpotsRepository, SpotRepository;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail, LocalSpot;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;

class SpotRepositoryMock implements SpotRepository, NowGoodSpotsRepository {
  static const _baseImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCvt-8qOtha-Zr10buBMyIFDjShZLLu9plZWs0jJHpK8u1Y2JeKj2E2cu8JmByDBBqxpNlyJOhX865sq4CUNsrFBOO3cSF2xeWYcVyJjZ2rNRmPG69mzPL76bDElgwWXeVgKZEO8X4vHndh7ov2uWAudVqtvvnOBBPJOsyzxW3If7rwfAsH93J9fXs0t99q5v2wwE3C_RWf7vh8v4sLmaxWRNmuEFX4pyo5AZVG4EDml98EsnVrFeGb5R-Adbpxk_4Pml1Y6XvGfd47';

  static const _cafeImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC0S33tImL1YLfQciYXXpEdYvFc9mJGTT1keQMljAA-hDdfYWk0vihV4zhekbC2tnmx_kmMEGfzhis2_9e-DhnNLnhD20ZwW2qdwSROWqKRUer8uoDgSHIxzztGT6wE4ZfGq8FNL0qrxaD2Hfyt_OTMkvbxnmy66DApgqZYvAgfdB1rC80sJb5QPFdrAVosSog0VI7--uOf-7a63Ko8TeY9NOQxLyNpf714LQ7uaK_sy_3OAwnMVGffMxenmBe1MG53P1g8Zu3JKlqy';

  static final _spots = <String, SpotDetail>{
    'spot-banghwasuryujeong': const SpotDetail(
      id: 'spot-banghwasuryujeong',
      name: '방화수류정',
      category: 'heritage-night-view',
      intro: '보물 제1709호. 평소에는 군사 시설이었으나 그 아름다움 덕에 정자로 더 사랑받는 곳입니다.',
      heroImageUrl: _baseImage,
      lat: 37.2870,
      lng: 127.0175,
      nightHighlight: '수면 반사와 정자 조명이 함께 보이는 구간.',
      photoTip: '난간 대신 정자와 수면을 함께 넣는 구도가 가장 예뻐요.',
      romanticMoment: '연인과 함께 성곽길을 따라 걸으며 서로의 첫인상을 이야기해보세요.',
      missionPrompt: '정자와 수면이 함께 보이는 지점을 찾아보세요.',
      missionRadiusM: 80,
      petPolicy: 'partial',
      petNote: '실외 이동은 가능하나 혼잡 시간대 리드줄 관리 필요',
      nearbySpots: [
        LocalSpot(
          id: 'local-cafe-01',
          name: "행리단길 카페 '메이븐'",
          type: 'cafe',
          summary: '코스 마무리 후 들르기 좋은 디저트 카페',
          imageUrl: _cafeImage,
          walkingMinutes: 7,
        ),
        LocalSpot(
          id: 'local-pub-01',
          name: '수원맥주',
          type: 'pub',
          summary: '로컬 수제맥주와 함께 밤을 마무리',
          imageUrl: _baseImage,
          walkingMinutes: 10,
        ),
      ],
    ),
    'spot-yongyeon': const SpotDetail(
      id: 'spot-yongyeon',
      name: '용연',
      category: 'heritage-night-view',
      intro: '방화수류정 아래 위치한 연못으로, 달빛이 수면에 반사되는 장면이 인상적입니다.',
      heroImageUrl: _baseImage,
      lat: 37.2885,
      lng: 127.0168,
      nightHighlight: '연못에 비친 달빛과 성곽의 실루엣을 활영해보세요.',
      photoTip: '연못 가장자리에서 수면 반영을 담으면 환상적인 사진이 나와요.',
      romanticMoment: '조용한 연못가에 앉아 달을 보며 이야기를 나눠보세요.',
      missionPrompt: '수면에 비친 반영을 담아보세요.',
      missionRadiusM: 80,
      nearbySpots: [],
    ),
    'spot-hwaseonghaenggung': const SpotDetail(
      id: 'spot-hwaseonghaenggung',
      name: '화성행궁',
      category: 'heritage-night-view',
      intro: '정조가 수원 화성을 축조하며 함께 지은 조선 최대 규모의 행궁입니다.',
      heroImageUrl: _baseImage,
      lat: 37.2836,
      lng: 127.0093,
      nightHighlight: '야간 조명이 켜진 정문(신풍루)과 행궁 담장의 실루엣이 인상적입니다.',
      photoTip: '신풍루 정면에서 조명과 처마선을 함께 담는 구도가 좋아요.',
      romanticMoment: '행궁 앞마당을 함께 거닐며 정조와 혜경궁 홍씨의 이야기를 나눠보세요.',
      missionPrompt: '신풍루 앞에서 인증샷을 남겨보세요.',
      missionRadiusM: 100,
      nearbySpots: [
        LocalSpot(
          id: 'local-cafe-02',
          name: '행리단길 디저트 가게',
          type: 'dessert',
          summary: '행궁 관람 후 들르기 좋은 디저트 맛집',
          imageUrl: _cafeImage,
          walkingMinutes: 5,
        ),
      ],
    ),
  };

  @override
  Future<SpotDetail> fetchSpotDetailAsync(String spotId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _spots[spotId] ?? _spots['spot-banghwasuryujeong']!;
  }

  @override
  Future<List<SpotSummary>> fetchNowGoodSpotsAsync() async {
    await Future.delayed(const Duration(milliseconds: 300));
    const nowGoodSpotIds = ['spot-banghwasuryujeong', 'spot-hwaseonghaenggung'];
    return nowGoodSpotIds
        .map((id) => _spots[id]!)
        .map(
          (spot) => SpotSummary(
            id: spot.id,
            slug: spot.id == 'spot-hwaseonghaenggung'
                ? 'hwaseong-haenggung'
                : 'banghwasuryujeong',
            name: spot.name,
            category: spot.category,
            heroImageUrl: spot.heroImageUrl,
            crowdLevel: '여유',
            distanceM: null,
            reasonLabel: '지금 비교적 여유로워요',
            recommendationScore: 82.35,
            forecastStatus: 'forecast_available',
          ),
        )
        .toList();
  }
}
