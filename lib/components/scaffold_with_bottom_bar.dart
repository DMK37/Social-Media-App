import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ScaffoldWithBottomBar extends StatelessWidget {
  const ScaffoldWithBottomBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 7, bottom: 20),
          child: GNav(
            gap: 8,
            hoverColor: Theme.of(context).bottomAppBarTheme.shadowColor!,
            iconSize: 25,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(15.0),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.add, text: 'Add'),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: _calculateSelectedIndex(context),
            onTabChange: (int index) => _onTap(index),
          )),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == '/') {
      return 0;
    }
    if (location.startsWith('/search')) {
      return 1;
    }
    if (location.startsWith('/create')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  void _onTap(int index) {
    if (navigationShell.currentIndex == index) {
      print("same index");
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
