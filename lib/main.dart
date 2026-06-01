import 'package:flutter/material.dart';
import 'screens/draft_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HoK Draft Simulator',
      theme: ThemeData.dark(),
      home: DraftScreen(),
    );
  }
}
