import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _statTile("Current Rank", "Grandmaster", Icons.trending_up),
                  _statTile(
                    "Highest Rank",
                    "Mythic 54 Stars",
                    Icons.workspace_premium,
                  ),
                  _statTile("Peak Points", "2,150", Icons.speed),
                  Divider(color: Colors.white24),
                  _buildHeroSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFC9A227).withValues(alpha: 0.4), Color(0xFF0D1117)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white10,
            child: Icon(Icons.person, size: 50),
          ),
          SizedBox(height: 10),
          Text(
            "HOKU_ProPlayer",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("UID: 982310221", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _statTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFC9A227)),
      title: Text(label),
      trailing: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Favorite Heroes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: List.generate(
            3,
            (i) => Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text("Hero $i")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
