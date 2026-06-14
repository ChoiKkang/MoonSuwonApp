class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabasePublishableKey,
    required this.kakaoNativeAppKey,
  });

  static const fromEnvironment = AppConfig(
    supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
    supabasePublishableKey: String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
    kakaoNativeAppKey: String.fromEnvironment('KAKAO_NATIVE_APP_KEY'),
  );

  final String supabaseUrl;
  final String supabasePublishableKey;
  final String kakaoNativeAppKey;

  void validateRequiredValues() {
    final missingKeys = <String>[
      if (supabaseUrl.trim().isEmpty) 'SUPABASE_URL',
      if (supabasePublishableKey.trim().isEmpty) 'SUPABASE_PUBLISHABLE_KEY',
      if (kakaoNativeAppKey.trim().isEmpty) 'KAKAO_NATIVE_APP_KEY',
    ];

    if (missingKeys.isNotEmpty) {
      throw StateError(
        'Missing required dart-define values: ${missingKeys.join(', ')}',
      );
    }
  }
}
