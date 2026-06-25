import 'package:flutter/material.dart';
import 'package:hoku/models/user_model.dart';
import 'package:hoku/screens/profile/settings_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user = AuthService.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _infoCard("Game Stats", [
                    _infoRow("UID", user?.uid ?? "-"),
                    _infoRow("Current Rank", user?.currentRank ?? "-"),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(color: Color(0xFF161B22)),
      child: Column(
        children: [
          CircleAvatar(radius: 50, backgroundColor: Color(0xFFC9A227), child: Icon(Icons.person, size: 50, color: Colors.black)),
          SizedBox(height: 15),
          Text(user?.nickname ?? "Legend", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(user?.email ?? "", style: TextStyle(color: Colors.white38)),
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
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
            Divider(),
            ...children
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
        children: [Text(label), Text(val, style: TextStyle(color: Colors.white70))],
      ),
    );
  }
}