# 달빛수원

수원화성 야간 데이트 코스 앱입니다.

## Local Config

앱 초기화 값은 빌드 타임에 주입합니다. 실제 설정 파일은 커밋하지 않습니다.

```bash
cp config/example.json config/dev.json
cp ios/Flutter/AppSecrets.xcconfig.example ios/Flutter/AppSecrets.xcconfig
```

`config/dev.json`에는 Flutter/Dart 초기화 값을 넣습니다.

```json
{
  "SUPABASE_URL": "https://your-project.supabase.co",
  "SUPABASE_PUBLISHABLE_KEY": "your-supabase-publishable-key",
  "KAKAO_NATIVE_APP_KEY": "your-kakao-native-app-key"
}
```

iOS 카카오 URL scheme은 `ios/Flutter/AppSecrets.xcconfig`의
`KAKAO_NATIVE_APP_KEY`를 사용합니다.

```bash
flutter run --dart-define-from-file=config/dev.json
```

VS Code/Cursor에서는 Run and Debug에서 `달빛수원 Dev` 구성을 선택합니다.
Android Studio에서는 `MoonSuwonApp Dev` Run Configuration을 선택합니다.
Xcode에서 직접 Run 버튼을 누르면 Dart `--dart-define` 값이 주입되지 않으므로,
일반 개발 실행은 Flutter 명령 또는 IDE의 Flutter Run Configuration을 사용합니다.

Android 카카오 URL scheme은 `--dart-define-from-file`의
`KAKAO_NATIVE_APP_KEY`를 우선 사용합니다. Flutter가 아닌 Gradle 직접 빌드에서는
`-PKAKAO_NATIVE_APP_KEY=...` 또는 환경 변수 `KAKAO_NATIVE_APP_KEY`를 사용할 수 있습니다.

Supabase `service_role` 키, Kakao Admin Key 같은 서버 전용 시크릿은 앱에 넣지 않습니다.
