import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts;

void main() {
  group('AccessibilityFacts', () {
    test('빈 정보는 그룹이 없고 hasInfo가 false다', () {
      const facts = AccessibilityFacts.empty;
      expect(facts.groups, isEmpty);
      expect(facts.hasInfo, isFalse);
    });

    test('값이 있는 항목만 세 그룹으로 묶고 순서를 유지한다', () {
      const facts = AccessibilityFacts(
        route: '완만한 경사로가 있습니다.',
        parking: '장애인 전용 주차구역이 있습니다.',
        helpDog: '안내견 동반이 가능합니다.',
        restroom: '장애인 화장실이 있습니다.',
      );

      final groups = facts.groups;
      expect(facts.hasInfo, isTrue);
      // 이동과 주차 → 안내와 보조 → 현장 편의 순서.
      expect(groups.map((g) => g.title), [
        '이동과 주차',
        '안내와 보조',
        '현장 편의',
      ]);
      expect(
        groups.first.items.map((i) => i.label),
        ['출입 동선', '주차'],
      );
      expect(groups[1].items.single.label, '안내견');
      expect(groups[2].items.single.label, '화장실');
    });

    test('값이 전부 빈 그룹은 제외한다', () {
      const facts = AccessibilityFacts(restroom: '장애인 화장실이 있습니다.');
      final groups = facts.groups;
      expect(groups, hasLength(1));
      expect(groups.single.title, '현장 편의');
    });

    test('공백만 있는 값은 표시하지 않고 값은 trim한다', () {
      const facts = AccessibilityFacts(route: '   ', parking: '  지상 주차  ');
      final groups = facts.groups;
      expect(groups, hasLength(1));
      final items = groups.single.items;
      expect(items, hasLength(1));
      expect(items.single.label, '주차');
      expect(items.single.value, '지상 주차');
    });
  });
}
