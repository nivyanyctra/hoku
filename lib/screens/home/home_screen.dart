import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOKU DASHBOARD"),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Banner Welcome
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Color(0xFFC9A227), Color(0xFF8E6E16)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back, Legend!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Your current rank: Grandmaster",
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),

          // Section Tournament News
          _buildSectionHeader("Live Tournament", "View All"),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildNewsCard(
                  "IKL Season 2",
                  "Grand Finals: RRQ vs EVOS",
                  Colors.blue,
                ),
                _buildNewsCard(
                  "KPL Summer",
                  "Estar Pro Win Streak",
                  Colors.red,
                ),
              ],
            ),
          ),
          SizedBox(height: 25),

          // Section Meta Heroes (Improvement Shortcut)
          _buildSectionHeader("Meta Improvement", "Tactics"),
          Card(
            color: Color(0xFF161B22),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.auto_awesome, color: Colors.black),
              ),
              title: Text("Expert Pick of the Day"),
              subtitle: Text(
                "How to counter 'Diaochan' with current meta items.",
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(action, style: TextStyle(color: Color(0xFFC9A227))),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String sub, Color color) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(sub, style: TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
}
