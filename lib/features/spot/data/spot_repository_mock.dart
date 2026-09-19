import 'package:dalbit_suwon/features/spot/data/spot_repository.dart'
    show NowGoodSpotsRepository, SpotRepository;
import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts;
import 'package:dalbit_suwon/features/spot/data/models/audio_story.dart'
    show AudioStory;
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
      petPolicy: 'allowed',
      petNote: '실외 성곽 산책로라 리드줄을 채우면 동반할 수 있어요. 배변봉투를 챙기고, 야간 혼잡 시간대에는 목줄을 짧게 잡아 주세요.',
      accessibility: AccessibilityFacts(
        route: '용연 방면 진입로는 완만하지만, 성곽 위 방화수류정까지는 계단과 돌바닥 경사 구간이 있습니다.',
        parking: '화홍문 공영주차장 이용 후 도보 약 5분.',
        publicTransport: '장안문·화홍문 정류장 하차 후 도보 8~10분.',
        wheelchair: '용연 수변 데크까지는 휠체어 접근이 가능하나 정자 상부는 계단으로 접근이 어렵습니다.',
        restroom: '용연 공원 공중화장실(장애인 화장실 포함) 이용 가능.',
        etc: '야간에는 바닥 조명이 낮아 단차가 잘 보이지 않으니 주의하세요.',
        sourceUpdatedAt: '2026-06-05',
      ),
      audioStories: [
        AudioStory(
          id: 'odii-banghwa-01',
          spotTitle: '방화수류정',
          audioTitle: '방화수류정 - 꽃을 찾고 버들을 따라',
          script:
              '방화수류정(訪花隨柳亭)은 1794년에 세운 수원화성의 동북각루입니다. '
              '이름은 "꽃을 찾고 버들을 따라간다"는 뜻으로, 군사 시설이면서도 주변 경관과 어우러진 '
              '정자로 지어졌습니다. 아래로는 용연이 있어, 달빛이 수면에 비칠 때 가장 아름답습니다.',
          playSeconds: null,
          audioUrl: null,
          distanceM: 15,
        ),
        AudioStory(
          id: 'odii-yongyeon-near',
          spotTitle: '용연',
          audioTitle: '용연에 비친 달',
          script:
              '용연(龍淵)은 방화수류정 아래에 자리한 연못입니다. 성곽 방어를 위한 해자 역할과 '
              '함께 휴식의 공간으로 쓰였습니다. 밤에 정자 조명이 켜지면 수면에 그림자가 겹쳐 '
              '한 폭의 그림 같은 풍경이 됩니다.',
          playSeconds: null,
          audioUrl: null,
          distanceM: 60,
        ),
      ],
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
      petPolicy: 'partial',
      petNote: '외부 광장은 리드줄 착용 시 동반할 수 있으나, 전각 내부와 유료 관람 구역은 반려동물 출입이 제한됩니다. 안내견은 예외입니다.',
      accessibility: AccessibilityFacts(
        route: '매표소에서 신풍루까지 완만한 포장길로 이어져 휠체어 이동이 수월합니다.',
        exit: '정문(신풍루) 측면에 단차 없는 출입 동선이 마련되어 있습니다.',
        parking: '화성행궁 공영주차장에 장애인 전용 주차구역이 있습니다.',
        wheelchair: '주요 관람 동선은 평지이나 일부 전각은 문턱과 계단이 있습니다.',
        publicTransport: '수원역·팔달문 방면 버스 이용 후 도보 5분.',
        helpDog: '안내견 동반 입장이 가능합니다.',
        restroom: '장애인 화장실이 매표소 인근과 관람로 중간에 있습니다.',
        lactationRoom: '관광안내소 내 수유 공간을 이용할 수 있습니다.',
        sourceUpdatedAt: '2026-06-05',
      ),
      audioStories: [
        AudioStory(
          id: 'odii-haenggung-01',
          spotTitle: '화성행궁',
          audioTitle: '화성행궁 신풍루 - 정조의 효심이 머문 곳',
          script:
              '신풍루(新豊樓)는 화성행궁의 정문입니다. 정조는 아버지 사도세자의 묘를 수원으로 옮기고 '
              '자주 이곳에 머물렀습니다. "신풍"은 임금의 고향을 뜻하는 말로, 수원을 제2의 고향으로 삼은 '
              '정조의 마음이 담겨 있습니다.',
          playSeconds: 192,
          // 데모용 공개 샘플 mp3. 실제 서비스에서는 KTO 오디(Odii) 오디오 URL로 교체된다.
          audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
          distanceM: 30,
        ),
      ],
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
  Future<List<SpotSummary>> fetchNowGoodSpotsAsync({
    double? lat,
    double? lng,
    int limit = 20,
  }) async {
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
