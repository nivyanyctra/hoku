import 'package:flutter/material.dart';

class CirclePage extends StatelessWidget {
  final List<Map<String, String>> jobs = [
    {
      "role": "Pro Player (Jungler)",
      "team": "RRQ HOK",
      "salary": "IDR 15M - 25M",
      "req": "Mythic 100+ Stars",
    },
    {
      "role": "Head Coach",
      "team": "Alter Ego",
      "salary": "Negotiable",
      "req": "Experience in KPL/IKL",
    },
    {
      "role": "Team Manager",
      "team": "Bigetron Esports",
      "salary": "IDR 10M - 15M",
      "req": "Management Background",
    },
    {
      "role": "Data Analyst",
      "team": "ONIC Esports",
      "salary": "IDR 8M - 12M",
      "req": "Deep HOK Mechanic Knowledge",
    },
  ];

  CirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOK CAREER"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search jobs (Player, Coach...)",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 15),
            color: Color(0xFF161B22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFC9A227),
                        child: Text(
                          jobs[index]['team']![0],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jobs[index]['role']!,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              jobs[index]['team']!,
                              style: TextStyle(color: Color(0xFFC9A227)),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.bookmark_border, color: Colors.white54),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5),
                      Text(
                        jobs[index]['salary']!,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Requirements: ${jobs[index]['req']}",
                    style: TextStyle(fontSize: 13, color: Colors.white54),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Quick Apply"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton(onPressed: () {}, child: Text("Details")),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
