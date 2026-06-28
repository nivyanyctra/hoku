import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'leagues/leagues_screen.dart';
import 'career/career_screen.dart';
import 'academy/academy_screen.dart';
import 'profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  static _MainNavigationState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainNavigationState>();

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  set index(int i) => setState(() => _index = i);
  
  final screens = [
    HomePage(),
    LeaguesPage(),
    CareerPage(),
    AcademyPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_index],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.transparent,
        color: Color(0xFFC9A227),
        index: _index,
        onTap: (i) => setState(() => _index = i),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.emoji_events, size: 30, color: Colors.white),
          Icon(Icons.people, size: 30, color: Colors.white),
          Icon(Icons.auto_fix_high, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
