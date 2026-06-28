// lib/main.dart
import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'models/user_model.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_navigation.dart';

void main() async {
  // 1. Wajib panggil ini sebelum operasi async di main
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Cek Session dari SharedPreferences
  final userId = await DatabaseService.instance.getSession();
  
  if (userId != null) {
    // 3. Ambil data lengkap user dari SQLite berdasarkan ID session
    final db = await DatabaseService.instance.database;
    final res = await db.query('users', where: 'id = ?', whereArgs: [userId]);
    
    if (res.isNotEmpty) {
      // 4. Set ke Global State
      AuthService.currentUser = UserModel.fromMap(res.first);
    } else {
      // Jika ID ada tapi di DB tidak ada (kasus akun dihapus), hapus session
      await DatabaseService.instance.clearSession();
    }
  }

  runApp(HokuApp(isLoggedIn: AuthService.currentUser != null));
}

class HokuApp extends StatelessWidget {
  final bool isLoggedIn;
  const HokuApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFC9A227),
        scaffoldBackgroundColor: const Color(0xFF0A0E14),
      ),
      // Jika isLoggedIn true, langsung ke MainNavigation, jika tidak ke Login
      home: isLoggedIn ? const MainNavigation() : LoginScreen(),
    );
  }
}
// class HokuApp extends StatelessWidget {
//   const HokuApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HOKU',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: const Color(0xFFC9A227),
//         scaffoldBackgroundColor: const Color(0xFF0D1117),
//         cardColor: const Color(0xFF161B22),
//         colorScheme: ColorScheme.dark(
//           primary: const Color(0xFFC9A227),
//           secondary: Colors.blueAccent,
//         ),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
