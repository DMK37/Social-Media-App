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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: GNav(
            gap: 8,
            color: Colors.grey[600],
            activeColor: Colors.black,
            hoverColor: Colors.grey[100]!,
            iconSize: 20,
            duration: const Duration(milliseconds: 300),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.add, text: 'Add'),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            onTabChange: (int index) => _onTap(context, index),)),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}