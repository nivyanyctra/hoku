import 'package:flutter/material.dart';

class AcademyPage extends StatefulWidget {
  const AcademyPage({super.key});

  @override
  State<AcademyPage> createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  List<String> enemyPicks = [];
  String recommendation =
      "Pilih hero lawan untuk mendapatkan rekomendasi counter.";

  void getExpertAdvice(String hero) {
    // Logika Sistem Pakar Sederhana
    setState(() {
      if (hero == "Marco Polo") {
        recommendation =
            "Counter Marco Polo: Gunakan Gongsun Li (Outrange/Mobility) atau Consort Yu. Item: Ominous Premonition.";
      } else if (hero == "Lu Bu") {
        recommendation =
            "Counter Lu Bu: Hero lincah seperti Li Bai atau Han Xin. Jangan kumpul saat ulti. Item: Nightmare.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tactics & Improvement")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue.withValues(alpha: 0.1),
            child: Row(
              children: [
                Icon(Icons.psychology, color: Colors.amber),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    recommendation,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              itemCount: 6, // Contoh 6 hero
              itemBuilder: (ctx, i) {
                String heroName = [
                  "Marco Polo",
                  "Lu Bu",
                  "Sima Yi",
                  "Shangguan",
                  "Diaochan",
                  "Kaiser",
                ][i];
                return GestureDetector(
                  onTap: () => getExpertAdvice(heroName),
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(child: Container(color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(heroName, style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            "Draft Simulation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => CircleAvatar(
                radius: 25,
                backgroundColor: Colors.red.withValues(alpha: 0.3),
                child: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
