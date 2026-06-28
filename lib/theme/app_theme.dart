// lib/main.dart
import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
// import '../screens/main_navigation.dart';

void main() => runApp(HokuApp());

class HokuApp extends StatelessWidget {
  const HokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOKU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFC9A227),
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        cardColor: const Color(0xFF161B22),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFC9A227),
          secondary: Colors.blueAccent,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
