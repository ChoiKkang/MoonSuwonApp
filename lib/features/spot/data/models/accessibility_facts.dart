import 'package:freezed_annotation/freezed_annotation.dart';

part 'accessibility_facts.freezed.dart';
part 'accessibility_facts.g.dart';

/// 무장애 여행 정보(편의시설과 접근성) 표시 규칙.
///
/// 한국관광공사(KTO)는 접근성을 등급이 아니라 자유 문장으로 보낸다.
/// "출입구까지 완만한 경사로가 설치되어 있음"처럼 서술형이라 등급으로 환산하면
/// 사실이 왜곡된다. 그래서 원문을 그대로 보여주고 값이 없는 항목은 감춘다.
/// 반려동물 정보와 같은 정책이며, 웹(`src/lib/places/accessibility.ts`)의
/// 계약을 그대로 옮겨 왔다.
///
/// copyWith는 쓰지 않는 값 객체다. SpotDetail이 이 타입을 단일 필드로 품는데,
/// freezed의 중첩 deep-copyWith가 생성 클래스명(`$AccessibilityFactsCopyWith`)을
/// 요구해 `show` 임포트 규칙과 충돌하므로 copyWith 생성을 끈다.
@Freezed(copyWith: false)
abstract class AccessibilityFacts with _$AccessibilityFacts {
  const AccessibilityFacts._();

  const factory AccessibilityFacts({
    String? route,
    String? exit,
    String? elevator,
    String? parking,
    String? publicTransport,
    String? wheelchair,
    String? brailleBlock,
    String? braillePromotion,
    String? audioGuide,
    String? bigPrint,
    String? helpDog,
    String? restroom,
    String? lactationRoom,
    String? stroller,
    String? infantsFamily,
    String? etc,
    String? sourceUpdatedAt,
  }) = _AccessibilityFacts;

  factory AccessibilityFacts.fromJson(Map<String, dynamic> json) =>
      _$AccessibilityFactsFromJson(json);

  /// 값이 전부 비어 있는 접근성 정보. 코스 경로처럼 접근성을 조회하지 않는
  /// 화면에서 기본값으로 쓴다.
  static const empty = AccessibilityFacts();

  /// 항목을 세 갈래로 묶는다. 방문자가 찾는 순서가 이동 가능 여부, 안내 수단,
  /// 현장 편의라서 그 순서대로 배치한다. 값이 없는 항목과 빈 그룹은 제외한다.
  List<AccessibilityGroup> get groups {
    final grouped = <AccessibilityGroup>[
      AccessibilityGroup(
        title: '이동과 주차',
        items: _pick([
          ('출입 동선', route),
          ('출입구', exit),
          ('엘리베이터', elevator),
          ('주차', parking),
          ('대중교통', publicTransport),
          ('휠체어', wheelchair),
        ]),
      ),
      AccessibilityGroup(
        title: '안내와 보조',
        items: _pick([
          ('점자블록', brailleBlock),
          ('점자 안내', braillePromotion),
          ('오디오 안내', audioGuide),
          ('큰 활자', bigPrint),
          ('안내견', helpDog),
        ]),
      ),
      AccessibilityGroup(
        title: '현장 편의',
        items: _pick([
          ('화장실', restroom),
          ('수유실', lactationRoom),
          ('유아차', stroller),
          ('영유아', infantsFamily),
          ('기타', etc),
        ]),
      ),
    ];

    return grouped.where((group) => group.items.isNotEmpty).toList();
  }

  /// 표시할 항목이 하나라도 있는지. 없으면 카드를 렌더하지 않는다.
  bool get hasInfo => groups.isNotEmpty;

  static List<AccessibilityItem> _pick(List<(String, String?)> entries) {
    return entries
        .where((entry) => entry.$2 != null && entry.$2!.trim().isNotEmpty)
        .map((entry) => AccessibilityItem(
              label: entry.$1,
              value: entry.$2!.trim(),
            ))
        .toList();
  }
}

/// 화면에 그리는 접근성 그룹(제목 + 항목들).
class AccessibilityGroup {
  const AccessibilityGroup({required this.title, required this.items});

  final String title;
  final List<AccessibilityItem> items;
}

/// 접근성 개별 항목(라벨 + 원문 값).
class AccessibilityItem {
  const AccessibilityItem({required this.label, required this.value});

  final String label;
  final String value;
}
