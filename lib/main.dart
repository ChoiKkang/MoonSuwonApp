import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:dalbit_suwon/core/router/app_router.dart' show appRouter;
import 'package:dalbit_suwon/core/theme/app_theme.dart' show AppTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://feifvxhltehhsugizrob.supabase.co',
    publishableKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZlaWZ2eGhsdGVoaHN1Z2l6cm9iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE0MTc2NDIsImV4cCI6MjA5Njk5MzY0Mn0.-ZVjIgl-uhgRSXxamqXc0EQ2kurbXtfjOK5uLNIOj0s',
  );

  KakaoSdk.init(nativeAppKey: 'f5cd252fd4129dc5b7a13683013bd151');

  runApp(const ProviderScope(child: DalbitSuwonApp()));
}

class DalbitSuwonApp extends StatelessWidget {
  const DalbitSuwonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '달빛수원',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
