import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dalbit_suwon/core/router/app_router.dart' show appRouter;
import 'package:dalbit_suwon/core/theme/app_theme.dart' show AppTheme;

void main() {
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
