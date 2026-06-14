import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/auth/data/auth_exceptions.dart' show EmailAlreadyInUseException;

void main() {
  group('EmailAlreadyInUseException', () {
    test('Exception을 구현한다', () {
      expect(const EmailAlreadyInUseException(), isA<Exception>());
    });

    test('throw/catch 가능하다', () {
      expect(
        () => throw const EmailAlreadyInUseException(),
        throwsA(isA<EmailAlreadyInUseException>()),
      );
    });

    test('const 생성자로 동일 인스턴스를 반환한다', () {
      const e1 = EmailAlreadyInUseException();
      const e2 = EmailAlreadyInUseException();
      expect(identical(e1, e2), isTrue);
    });
  });
}
