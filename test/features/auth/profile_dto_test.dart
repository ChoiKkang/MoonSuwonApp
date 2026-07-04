import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/auth/data/models/profile_dto.dart'
    show ProfileDto, isApplePrivateRelayEmail;

void main() {
  group('ProfileDto', () {
    test('provider subject와 비공개 이메일 여부를 JSON에 포함한다', () {
      final dto = ProfileDto(
        id: 'user-id',
        email: 'relay@privaterelay.appleid.com',
        nickname: null,
        avatarUrl: null,
        provider: 'apple',
        providerSub: 'apple-sub',
        isPrivateEmail: true,
        updatedAt: DateTime.utc(2026, 7, 4),
      );

      expect(dto.toJson(), {
        'id': 'user-id',
        'email': 'relay@privaterelay.appleid.com',
        'provider': 'apple',
        'provider_sub': 'apple-sub',
        'is_private_email': true,
        'updated_at': '2026-07-04T00:00:00.000Z',
      });
    });

    test('Apple 비공개 relay 이메일을 대소문자와 공백에 관계없이 판별한다', () {
      expect(
        isApplePrivateRelayEmail(' User@PrivateRelay.AppleID.Com '),
        isTrue,
      );
      expect(isApplePrivateRelayEmail('user@example.com'), isFalse);
      expect(isApplePrivateRelayEmail(null), isFalse);
    });
  });
}
