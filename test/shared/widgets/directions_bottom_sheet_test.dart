import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/shared/widgets/directions_bottom_sheet.dart'
    show DirectionsBottomSheet;

Widget _harnessApp(void Function(BuildContext) onReady) {
  return MaterialApp(
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => onReady(context),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('DirectionsBottomSheet', () {
    testWidgets('시트에 카카오/네이버/구글 3개 옵션이 노출된다', (tester) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        _harnessApp((ctx) => capturedContext = ctx),
      );
      // 트리에서 context 를 캡처하기 위해 버튼 탭 (실제 시트 오픈은 별도 호출)
      await tester.tap(find.text('open'));
      await tester.pump();

      // 시트 자체는 async 대기이므로 unawaited로 띄우고 pumpAndSettle
      unawaitedShow() {
        DirectionsBottomSheet.showAsync(
          capturedContext,
          destinationName: '방화수류정',
          lat: 37.2870,
          lng: 127.0175,
        );
      }

      unawaitedShow();
      await tester.pumpAndSettle();

      expect(find.text('길찾기 앱 선택'), findsOneWidget);
      expect(find.text('카카오맵으로 길찾기'), findsOneWidget);
      expect(find.text('네이버맵으로 길찾기'), findsOneWidget);
      expect(find.text('구글맵으로 길찾기'), findsOneWidget);
    });

    testWidgets('바깥을 탭하면 시트가 닫힌다', (tester) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        _harnessApp((ctx) => capturedContext = ctx),
      );
      await tester.tap(find.text('open'));
      await tester.pump();

      DirectionsBottomSheet.showAsync(
        capturedContext,
        destinationName: '방화수류정',
        lat: 37.2870,
        lng: 127.0175,
      );
      await tester.pumpAndSettle();
      expect(find.text('길찾기 앱 선택'), findsOneWidget);

      // barrier dismiss
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.text('길찾기 앱 선택'), findsNothing);
    });
  });
}
