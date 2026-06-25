import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'leagues/leagues_screen.dart';
import 'career/career_screen.dart';
import 'academy/academy_screen.dart';
import 'profile/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
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
      body: screens[_index],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _index,
      //   onTap: (i) => setState(() => _index = i),
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Color(0xFFC9A227),
      //   unselectedItemColor: Colors.white60,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Leagues"),
      //     BottomNavigationBarItem(icon: Icon(Icons.people), label: "Circle"),
      //     BottomNavigationBarItem(icon: Icon(Icons.auto_fix_high), label: "Academy"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      //   ],
      // ),
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
