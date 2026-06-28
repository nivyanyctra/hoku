import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'settings_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AuthService.userNotifier, // Pantau perubahan data user
      builder: (context, user, child) {
        final userData = user ?? AuthService.currentUser;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0E14),
          appBar: AppBar(
            title: const Text("MY PROFILE"),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(userData),
                _infoCard("Stats", [
                  _infoRow("UID", userData?.uid ?? ""),
                  _infoRow("Rank", userData?.currentRank ?? ""),
                ])
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(UserModel? user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      color: const Color(0xFF161B22),
      child: Column(
        children: [
          const CircleAvatar(radius: 40, backgroundColor: Color(0xFFC9A227), child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 15),
          Text(user?.nickname ?? "", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(user?.email ?? "", style: const TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }

  Widget _infoCard(String title, List<Widget> children) {
    return Card(
      color: Color(0xFF161B22),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(val, style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
