import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:dalbit_suwon/core/config/app_config.dart' show AppConfig;
import 'package:dalbit_suwon/core/router/app_router.dart'
    show appRouterProvider;
import 'package:dalbit_suwon/core/theme/app_theme.dart' show AppTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appConfig = AppConfig.fromEnvironment;
  appConfig.validateRequiredValues();

  await Supabase.initialize(
    url: appConfig.supabaseUrl,
    publishableKey: appConfig.supabasePublishableKey,
  );

  // 앱 시작 시 서버에 세션 유효성 검증
  // 계정 삭제·만료 등으로 refresh token이 무효화된 경우 로컬 세션을 초기화
  final auth = Supabase.instance.client.auth;
  if (auth.currentSession != null) {
    try {
      await auth.refreshSession();
    } catch (_) {
      await auth.signOut();
    }
  }

  KakaoSdk.init(nativeAppKey: appConfig.kakaoNativeAppKey);

  runApp(const ProviderScope(child: DalbitSuwonApp()));
}

class DalbitSuwonApp extends ConsumerWidget {
  const DalbitSuwonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: '달빛수원',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
