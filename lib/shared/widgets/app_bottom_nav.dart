import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppBottomNavTab { home, nearby, bookmarks, my }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentTab});

  final AppBottomNavTab currentTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      onTap: (index) => _onTap(context, AppBottomNavTab.values[index]),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(
            icon: Icon(Icons.near_me_outlined), label: '내 주변'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline), label: '찜'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이'),
      ],
    );
  }

  void _onTap(BuildContext context, AppBottomNavTab tab) {
    if (tab == currentTab) return;
    switch (tab) {
      case AppBottomNavTab.home:
        context.go('/');
      case AppBottomNavTab.my:
        context.go('/mypage');
      case AppBottomNavTab.nearby:
      case AppBottomNavTab.bookmarks:
        break;
    }
  }
}
