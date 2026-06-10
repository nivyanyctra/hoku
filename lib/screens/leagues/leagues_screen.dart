import 'package:flutter/material.dart';

class LeaguesPage extends StatelessWidget {
  const LeaguesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HOK Tournaments"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "IKL"),
              Tab(text: "MKL"),
              Tab(text: "KPL"),
              Tab(text: "International"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLeagueList("Indonesia Kings League"),
            _buildLeagueList("Malaysia Kings League"),
            _buildLeagueList("King Pro League"),
            _buildLeagueList("Global Events"),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueList(String title) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Upcoming Matches",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _matchCard("RRQ", "EVOS", "19:00 WIB", "Live"),
        _matchCard("ONIC", "BTR", "21:00 WIB", "Upcoming"),
        SizedBox(height: 20),
        Text(
          "Group Standings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Card(
          child: Column(
            children: [
              _standingRow("1", "Team RRQ", "6-0"),
              _standingRow("2", "Team EVOS", "4-2"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _matchCard(String t1, String t2, String time, String status) {
    return Card(
      color: Color(0xFF1C2128),
      child: ListTile(
        leading: Text(time, style: TextStyle(color: Colors.amber)),
        title: Center(child: Text("$t1 vs $t2")),
        trailing: Container(
          padding: EdgeInsets.all(5),
          color: status == "Live" ? Colors.red : Colors.grey,
          child: Text(status, style: TextStyle(fontSize: 10)),
        ),
      ),
    );
  }

  Widget _standingRow(String pos, String team, String score) {
    return ListTile(
      leading: Text(pos),
      title: Text(team),
      trailing: Text(score),
    );
  }
}
