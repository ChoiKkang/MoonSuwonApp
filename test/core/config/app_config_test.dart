import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/core/config/app_config.dart' show AppConfig;

void main() {
  group('AppConfig', () {
    test('fromEnvironment reads supported dart define keys', () {
      expect(
        AppConfig.fromEnvironment.supabaseUrl,
        const String.fromEnvironment('SUPABASE_URL'),
      );
      expect(
        AppConfig.fromEnvironment.supabasePublishableKey,
        const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
      );
      expect(
        AppConfig.fromEnvironment.kakaoNativeAppKey,
        const String.fromEnvironment('KAKAO_NATIVE_APP_KEY'),
      );
    });

    test('validateRequiredValues throws with missing key names', () {
      const config = AppConfig(
        supabaseUrl: '',
        supabasePublishableKey: 'publishable-key',
        kakaoNativeAppKey: ' ',
      );

      expect(
        config.validateRequiredValues,
        throwsA(
          isA<StateError>()
              .having(
                (error) => error.message,
                'message',
                contains('SUPABASE_URL'),
              )
              .having(
                (error) => error.message,
                'message',
                contains('KAKAO_NATIVE_APP_KEY'),
              ),
        ),
      );
    });

    test('validateRequiredValues accepts complete config', () {
      const config = AppConfig(
        supabaseUrl: 'https://example.supabase.co',
        supabasePublishableKey: 'publishable-key',
        kakaoNativeAppKey: 'native-key',
      );

      expect(config.validateRequiredValues, returnsNormally);
    });
  });
}
